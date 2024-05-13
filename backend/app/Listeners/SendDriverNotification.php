<?php

namespace App\Listeners;

use App\Events\DriverRequest;
use App\Jobs\SendDriverNotificationJob;
use Illuminate\Contracts\Queue\ShouldQueue;
use Illuminate\Queue\InteractsWithQueue;

class SendDriverNotification
{
    /**
     * Create the event listener.
     */
    public function __construct()
    {
        //
    }

    /**
     * Handle the event.
     */
    public function handle(DriverRequest $event): void
    {
        $driverRequest = $event->driverRequest;

        dispatch(new SendDriverNotificationJob($driverRequest));
    }
}
