<?php

namespace App\Jobs;

use App\Models\DriverRequest;
use App\Models\Notification;
use App\Models\User;
use App\Notifications\FirebaseNotification;
use Illuminate\Bus\Queueable;
use Illuminate\Contracts\Queue\ShouldQueue;
use Illuminate\Foundation\Bus\Dispatchable;
use Illuminate\Queue\InteractsWithQueue;
use Illuminate\Queue\SerializesModels;

class SendDriverNotificationJob implements ShouldQueue
{
    use Dispatchable, InteractsWithQueue, Queueable, SerializesModels;

    protected $driverRequest;

    /**
     * Create a new job instance.
     */
    public function __construct(DriverRequest $driverRequest)
    {
        $this->driverRequest = $driverRequest;
    }

    /**
     * Execute the job.
     */
    public function handle(): void
    {
        $drivers = User::where('role_id', 3)->get();

        foreach ($drivers as $driver) {
            $driver->notify(new FirebaseNotification('New driver request has been sent.'));

            Notification::create([
                'user_id' => $driver->id,
                'message' => 'New driver request has been sent.',
            ]);
        }
    }
}
