<?php

namespace App\Controller;

use App\Entity\News;
use App\Entity\User;
use App\Entity\Comment;
use App\Form\CommentType;
use App\Form\NewsType;
use App\Repository\NewsRepository;
use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Annotation\Route;
use Symfony\Component\Security\Core\Security;

#[Route('/news')]
class NewsController extends AbstractController
{
    #[Route('/', name: 'news_index', methods: ['GET'])]
    public function index(NewsRepository $newsRepository): Response
    {
        return $this->render('news/index.html.twig', [
            'news' => $newsRepository->findBy([], ['date'=>'DESC']),
        ]);
    }

   
    #[Route('/{id}', name: 'news_show', methods: ['GET', "POST"])]
    public function show(News $news,Request $request, Security $security): Response
    {
        //получаем текущего пользователя
        $user=$security->getUser();
        if($user==null) {
            $news->incrementCountView();
            // Обновляем сущность поста в БД
            $entityManager = $this->getDoctrine()->getManager();
            $entityManager->persist($news);
            $entityManager->flush();
        }
         elseif (array_search('ROLE_ADMIN',$user->getRoles())==false && array_search('ROLE_ADMIN',$user->getRoles())!=0) {
            $news->incrementCountView();
            $entityManager = $this->getDoctrine()->getManager();
            $entityManager->persist($news);
            $entityManager->flush();
        }
         // Создаем форму для добавления комментария к посту
         $form = $this->createForm(CommentType::class);
         $form->handleRequest($request);
         if ($form->isSubmitted()) {    
             $commentBody = $form->get('commentBody')->getData();
             $comment = new Comment();
             $comment->setUserId($user);
             $comment->setText($commentBody);
             $news->addComment($comment);

             $entityManager = $this->getDoctrine()->getManager();
             $entityManager->persist($news);
             $entityManager->flush();
            return $this->redirectToRoute('news_show', ['id' => $news->getId()]);
        }
        return $this->render('news/show.html.twig', [
            'news' => $news,
            'comments' =>  $news->getComment(),
            'comment_form' => $form->createView(),
        ]);
    }

    #[Route('/{id}/edit', name: 'news_edit', methods: ['GET', 'POST'])]
    public function edit(Request $request, News $news): Response
    {
        $form = $this->createForm(NewsType::class, $news);
        $form->handleRequest($request);

        if ($form->isSubmitted() && $form->isValid()) {
            $this->getDoctrine()->getManager()->flush();

            return $this->redirectToRoute('news_index');
        }

        return $this->render('news/edit.html.twig', [
            'news' => $news,
            'form' => $form->createView(),
        ]);
    }

}
