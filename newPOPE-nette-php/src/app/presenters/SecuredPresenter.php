<?php

namespace App\Presenters;

abstract class SecuredPresenter extends BasePresenter {

  protected function startup() {
    parent::startup();

    $this->checkUserSignStatus();
  }

  protected function checkUserSignStatus() {
    if (!$this->signedUser->isSigned()) {
      $this->redirect('Sign:in');
    }
  }
}
