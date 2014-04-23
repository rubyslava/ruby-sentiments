<?php

namespace App\Presenters;

use App\Model\Events;
use App\Model\SignedUser;

class EventPresenter extends SecuredPresenter {

  /**
   * @var \App\Model\SignedUser
   * @inject
   */
  public $signedUser;

  /**
   * @var \App\Model\Events
   * @inject
   */
  public $events;

  public function actionSignIn($id) {
    $this->events->signUserTo(
      $this->signedUser->name,
      $id
    );

    $this->redirect('Homepage:');
  }
}
