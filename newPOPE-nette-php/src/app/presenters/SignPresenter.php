<?php

namespace App\Presenters;

use Nette;

class SignPresenter extends BasePresenter {

  /**
   * @var \App\Model\SignedUser
   * @inject
   */
  public $signedUser;

  protected function createComponentSignInForm() {
    $form = new Nette\Application\UI\Form;
    $form->addText('username', 'Username:')
         ->setRequired('Please enter your username.');

    $form->addSubmit('send', 'Sign in');

    $form->onSuccess[] = $this->signInFormSucceeded;

    return $form;
  }

  public function signInFormSucceeded($form) {
    $values = $form->getValues();

    $this->signedUser->sign($values['username']);
    $this->redirect('Homepage:');
  }
}
