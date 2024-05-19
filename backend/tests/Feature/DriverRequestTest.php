<?php

namespace Tests\Feature;

use App\Models\User;
use App\Models\DriverRequest;
use Illuminate\Foundation\Testing\DatabaseTransactions;
use Illuminate\Support\Facades\Hash;
use Illuminate\Support\Facades\Event;
use Tests\TestCase;
use PHPOpenSourceSaver\JWTAuth\Facades\JWTAuth;

class DriverRequestTest extends TestCase
{
    use DatabaseTransactions;

    private function createUser()
    {
        return User::factory()->create([
            'first_name' => 'Test',
            'last_name' => 'User',
            'email' => 'testuser@example.com',
            'password' => Hash::make('password123'),
        ]);
    }

    private function createTokenForUser($user)
    {
        return JWTAuth::fromUser($user);
    }

    public function testDriverRequest()
    {
        Event::fake();

        $user = $this->createUser();
        $token = $this->createTokenForUser($user);

        $response = $this->postJson('/api/driverRequest', [], ['Authorization' => "Bearer $token"]);

        $response->assertStatus(200)
            ->assertJsonStructure([
                'message',
                'driver_request' => [
                    'id', 'user_id', 'status', 'created_at', 'updated_at'
                ]
            ]);

        $this->assertDatabaseHas('driver_requests', [
            'user_id' => $user->id,
            'status' => 'pending'
        ]);
    }
}
