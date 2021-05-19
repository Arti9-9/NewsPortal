<?php

namespace App\Controller\Admin;

use App\Entity\News;
use EasyCorp\Bundle\EasyAdminBundle\Controller\AbstractCrudController;
use EasyCorp\Bundle\EasyAdminBundle\Field\DateTimeField;
use EasyCorp\Bundle\EasyAdminBundle\Field\IntegerField;
use EasyCorp\Bundle\EasyAdminBundle\Field\TextEditorField;
use EasyCorp\Bundle\EasyAdminBundle\Field\TextField;

class NewsCrudController extends AbstractCrudController
{
    public static function getEntityFqcn(): string
    {
        return News::class;
    }

    public function configureFields(string $pageName): iterable
    {
    
        return [
            IntegerField::new('id')->hideOnForm(),
            TextField::new('name'),
            // Тело поста скрываем в отображаемом списке
            TextField::new('annotation'),
            IntegerField::new('countView'),
            TextField::new('text')->hideOnIndex(),
            DateTimeField::new('date')->hideOnForm(),   
        ];
    }
}
