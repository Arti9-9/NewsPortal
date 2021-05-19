<?php

namespace App\Controller;

use App\Repository\NewsRepository;
use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Annotation\Route;

class HomeController extends AbstractController
{
    
    #[Route('/', name: 'home')]
    public function index(NewsRepository $newsRepository): Response
    {
        
        return $this->render('news/index.html.twig', [
            'news' => $newsRepository->findBy([], ['date'=>'DESC']),
        ]);
    }
}
