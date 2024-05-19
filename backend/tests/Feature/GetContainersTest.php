<?php

namespace Tests\Feature;

use App\Models\User;
use Illuminate\Foundation\Testing\DatabaseTransactions;
use Illuminate\Support\Facades\Hash;
use Tests\TestCase;
use PHPOpenSourceSaver\JWTAuth\Facades\JWTAuth;

class GetContainersTest extends TestCase
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

    public function testGetContainers()
    {
        $user = $this->createUser();
        $token = $this->createTokenForUser($user);

        $response = $this->getJson('/api/containers', ['Authorization' => "Bearer $token"]);

        $response->assertStatus(200)
            ->assertJsonStructure([
                'containers' => [
                    '*' => [
                        'id', 'user_id', 'type_id', 'created_at', 'updated_at',
                        'type' => [
                            'id', 'name', 'created_at', 'updated_at'
                        ]
                    ]
                ]
            ]);
    }
}
