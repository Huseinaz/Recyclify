<?php

namespace App\Jobs;

use App\Models\Container;
use App\Models\Notification;
use App\Notifications\FirebaseNotification;
use Illuminate\Bus\Queueable;
use Illuminate\Contracts\Queue\ShouldQueue;
use Illuminate\Foundation\Bus\Dispatchable;
use Illuminate\Queue\InteractsWithQueue;
use Illuminate\Queue\SerializesModels;

class SendCapacityNotificationJob implements ShouldQueue
{
    use Dispatchable, InteractsWithQueue, Queueable, SerializesModels;

    protected $container;

    /**
     * Create a new job instance.
     */
    public function __construct(Container $container)
    {
        $this->container = $container;
    }

    /**
     * Execute the job.
     */
    public function handle(): void
    {
        $user = $this->container->user;

        foreach($user as $user){
            $user->notify(new FirebaseNotification("Your plastic container is full! Please request a driver."));

            Notification::create([
                'user_id' => $user->id,
                'message' => 'Your plastic container is full! Please request a driver.',
            ]);
        }
    }
}
