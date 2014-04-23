<?php

namespace App\Presenters;

class HomepagePresenter extends SecuredPresenter {

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
