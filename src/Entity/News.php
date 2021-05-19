<?php

namespace App\Entity;

use App\Repository\NewsRepository;
use Doctrine\Common\Collections\ArrayCollection;
use Doctrine\Common\Collections\Collection;
use Doctrine\ORM\Mapping as ORM;
use Doctrine\ORM\Mapping\OrderBy;
use DateTime;
use DateTimeInterface;

/**
 * @ORM\Entity(repositoryClass=NewsRepository::class)
 */
class News
{
    /**
     * @ORM\Id
     * @ORM\GeneratedValue
     * @ORM\Column(type="integer")
     */
    private $id;

    /**
     * @ORM\Column(type="string", length=255)
     */
    private $name;

    /**
     * @ORM\Column(type="datetime")
     */
    private $date;

    /**
     * @ORM\Column(type="string", length=255)
     */
    private $annotation;

    /**
     * @ORM\Column(type="text")
     */
    private $text;


    /**
     * @ORM\OneToMany(targetEntity=Comment::class, mappedBy="idNews", orphanRemoval=true, cascade={"persist"})
     */
    private $comment;

    /**
     * @ORM\Column(type="integer", options={"default" : 0})
     */
    private $countView;

  

    public function __construct()
    {
        $this->date = new DateTime();
        $this->comment = new ArrayCollection();
    }

    public function getId(): ?int
    {
        return $this->id;
    }

    public function getName(): ?string
    {
        return $this->name;
    }

    public function setName(string $name): self
    {
        $this->name = $name;

        return $this;
    }

    public function getDate(): ?\DateTimeInterface
    {
        return $this->date;
    }

    public function setDate(\DateTimeInterface $date): self
    {
        $this->date = $date;

        return $this;
    }

    public function getAnnotation(): ?string
    {
        return $this->annotation;
    }

    public function setAnnotation(string $annotation): self
    {
        $this->annotation = $annotation;

        return $this;
    }

    public function getText(): ?string
    {
        return $this->text;
    }

    public function setText(string $text): self
    {
        $this->text = $text;

        return $this;
    }

    /**
     * @return Collection|Comment[]
     */
    public function getComment(): Collection
    {
        return $this->comment;
    }

    public function addComment(Comment $comment): self
    {
        if (!$this->comment->contains($comment)) {
            $this->comment[] = $comment;
            $comment->setIdNews($this);
        }

        return $this;
    }

    public function removeComment(Comment $comment): self
    {
        if ($this->comment->removeElement($comment)) {
            // set the owning side to null (unless already changed)
            if ($comment->getIdNews() === $this) {
                $comment->setIdNews(null);
            }
        }

        return $this;
    }

    public function incrementCountView()
    {
        $currentCountView = $this->getCountView();
        if ($currentCountView) {
            $this->setCountView($currentCountView + 1);
        } else {
            $this->setCountView(1);
        }
    }

    public function getCountView(): ?int
    {
        return $this->countView;
    }

    public function setCountView(int $countView): self
    {
        $this->countView = $countView;

        return $this;
    }

    public function __toString()
    {
        return $this->name;
    }
}
