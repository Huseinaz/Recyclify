<?php

namespace Tests\Feature;

use App\Models\User;
use Illuminate\Foundation\Testing\DatabaseTransactions;
use Illuminate\Support\Facades\Hash;
use Tests\TestCase;
use PHPOpenSourceSaver\JWTAuth\Facades\JWTAuth;

class CreateDriverTest extends TestCase
{
    use DatabaseTransactions;

    private function createDriverUser()
    {
        return User::factory()->create([
            'first_name' => 'John',
            'last_name' => 'Doe',
            'email' => 'john.doe@example.com',
            'password' => Hash::make('password123'),
            'role_id' => 1,
        ]);
    }

    private function createTokenForUser($user)
    {
        return JWTAuth::fromUser($user);
    }

    public function testCreateDriver()
    {
        $user = $this->createDriverUser();
        $token = $this->createTokenForUser($user);

        $data = [
            'first_name' => 'Jane',
            'last_name' => 'Smith',
            'email' => 'jane.smith@example.com',
            'password' => 'password123'
        ];

        $response = $this->postJson('/api/createDriver', $data, ['Authorization' => "Bearer $token"]);

        $response->assertStatus(200)
                 ->assertJson([
                     'status' => 'success',
                     'message' => 'Driver created successfully'
                 ]);

        $this->assertDatabaseHas('users', [
            'first_name' => 'Jane',
            'last_name' => 'Smith',
            'email' => 'jane.smith@example.com',
            'role_id' => 3
        ]);

        $user = User::where('email', 'jane.smith@example.com')->first();
        $this->assertTrue(Hash::check('password123', $user->password));
    }
}
