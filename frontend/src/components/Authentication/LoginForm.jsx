import React from 'react'

const LoginForm = () => {
    return (
        <>
            <form>
                <div>
                    <label>Email</label>
                    <input
                        type="text"
                        name="email"
                        placeholder="user@mail.com"
                        required
                    />
                </div>
                <div>
                    <label>Password</label>
                    <input
                        type="password"
                        name="password"
                        placeholder="password"
                        required
                    />
                </div>
                <button
                    type="submit"
                >
                    Login
                </button>
            </form>
        </>
    )
}

export default LoginForm