<?php

namespace Tests\Feature;

use App\Models\User;
use Illuminate\Foundation\Testing\DatabaseTransactions;
use Illuminate\Support\Facades\Hash;
use Tests\TestCase;
use PHPOpenSourceSaver\JWTAuth\Facades\JWTAuth;

class GetUsersTest extends TestCase
{
    use DatabaseTransactions;

    private function createAdminUser()
    {
        return User::factory()->create([
            'first_name' => 'Admin',
            'last_name' => 'User',
            'email' => 'admin@example.com',
            'password' => Hash::make('password123'),
            'role_id' => 1,
        ]);
    }

    private function createTokenForUser($user)
    {
        return JWTAuth::fromUser($user);
    }

    public function testGetUserAsAdmin()
    {
        $admin = $this->createAdminUser();
        $token = $this->createTokenForUser($admin);

        $response = $this->getJson('/api/users/get', ['Authorization' => "Bearer $token"]);

        $response->assertStatus(200)
            ->assertJsonStructure([
                'user' => [
                    'id', 'first_name', 'last_name', 'email', 'role_id'
                ],
                'users' => [
                    '*' => ['id', 'first_name', 'last_name', 'email', 'role_id']
                ]
            ]);
    }
}
