<?php

namespace Tests\Feature;

use App\Models\User;
use Illuminate\Foundation\Testing\DatabaseTransactions;
use Illuminate\Support\Facades\Hash;
use Tests\TestCase;

class UsersControllerTest extends TestCase
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

    public function testActivateUser()
    {
        $user = $this->createUser(['active' => false]);

        $response = $this->postJson("/api/users/{$user->id}/activate");

        $response->assertStatus(200)
            ->assertJson(['message' => 'User activated successfully']);

        $user = $user->fresh();
    }

    public function testShutdownUser()
    {
        $user = $this->createUser(['active' => true]);

        $response = $this->postJson("/api/users/{$user->id}/shutdown");

        $response->assertStatus(200)
            ->assertJson(['message' => 'User shut down successfully']);

        $user = $user->fresh();
    }


    public function testDeleteUser()
    {
        $user = $this->createUser();

        $this->withoutMiddleware();

        $response = $this->deleteJson("/api/users/{$user->id}");

        $response->assertStatus(200)
            ->assertJson(['message' => 'User deleted successfully']);

        $this->assertNull(User::find($user->id));
    }

    public function testUserNotFound()
    {
        $response = $this->postJson("/api/users/123/activate");

        $response->assertStatus(404)
            ->assertJson(['message' => 'User not found']);
    }
}
