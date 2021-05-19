<?php

namespace App\DataFixtures;

use App\Entity\User;
use Doctrine\Bundle\FixturesBundle\Fixture;
use Doctrine\Persistence\ObjectManager;
use Symfony\Component\Security\Core\Encoder\UserPasswordEncoderInterface;

class Users extends Fixture
{
    private $passwordEncoder;
    public function __construct(UserPasswordEncoderInterface $passwordEncoder)
    {
        $this->passwordEncoder = $passwordEncoder;
    }
    public function load(ObjectManager $manager)
    {
        $admin= new User();
        $user=new User();
        $admin->setEmail('artema@admin.com');
        $admin->setName('Admin');
        $admin->setSurname('Admin');
        $admin->setPassword($this->passwordEncoder->encodePassword($admin, 'admin'));
        $admin->setRoles(['ROLE_ADMIN']);
            
        $user->setEmail('artem@user.com');
        $user->setName('Artem');
        $user->setSurname('Osipov');
        $user->setPassword($this->passwordEncoder->encodePassword($user, 'asd123'));

        $manager->persist($admin);
        $manager->persist($user);
            
        $manager->flush();
    }
}
