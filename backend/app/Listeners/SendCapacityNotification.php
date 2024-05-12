<?php

namespace App\Listeners;

use App\Events\ContainerCapacityExceeded;
use App\Jobs\SendCapacityNotificationJob;
use Illuminate\Contracts\Queue\ShouldQueue;
use Illuminate\Queue\InteractsWithQueue;

class SendCapacityNotification
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
    public function handle(ContainerCapacityExceeded $event)
    {
        $container = $event->container;

        if ($container->capacity >= 90) {
            dispatch(new SendCapacityNotificationJob($container));
        }
    }
}
