<?php

namespace App\Presenters;

use App\Model\Events;

class HomepagePresenter extends BasePresenter {

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

  public function renderDefault() {
    if(!$this->signedUser->isSigned()) {
      $this->redirect('Sign:in');
    }

    $this->template->username = $this->signedUser->name;
    $this->template->events = $this->events->findPublic();
  }

  public function isUserAttendedTo($eventId) {
    return $this->events->isUserAttendedTo(
      $this->signedUser->name,
      $eventId
    );
  }
}
