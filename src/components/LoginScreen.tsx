import React, { useState } from 'react';
import { Mail, Lock, Eye, EyeOff, ArrowRight } from 'lucide-react';
import { Screen } from '../types';

interface LoginScreenProps {
  onNavigate: (screen: Screen) => void;
}

export const LoginScreen: React.FC<LoginScreenProps> = ({ onNavigate }) => {
  const [email, setEmail] = useState('');
  const [password, setPassword] = useState('');
  const [showPassword, setShowPassword] = useState(false);

  const handleLogin = () => {
    // Simulate login
    onNavigate('dashboard');
  };

  const handleGoogleLogin = () => {
    // Simulate Google login
    onNavigate('dashboard');
  };

  return (
    <div className="min-h-screen bg-gradient-to-br from-primary-50 to-accent-50 flex flex-col px-6 py-8">
      <div className="flex-1 flex flex-col justify-center max-w-sm mx-auto w-full">
        <div className="text-center mb-8">
          <h1 className="text-3xl font-bold text-gray-900 mb-2">Welcome Back</h1>
          <p className="text-gray-600">Sign in to your FinDiu campus account</p>
        </div>

        {/* Google Login Button */}
        <button
          onClick={handleGoogleLogin}
          className="w-full bg-white border-2 border-gray-200 text-gray-700 py-3 rounded-2xl font-semibold flex items-center justify-center space-x-3 hover:bg-gray-50 hover:border-gray-300 transition-all mb-6"
        >
          <svg className="w-5 h-5" viewBox="0 0 24 24">
            <path fill="#4285F4" d="M22.56 12.25c0-.78-.07-1.53-.2-2.25H12v4.26h5.92c-.26 1.37-1.04 2.53-2.21 3.31v2.77h3.57c2.08-1.92 3.28-4.74 3.28-8.09z"/>
            <path fill="#34A853" d="M12 23c2.97 0 5.46-.98 7.28-2.66l-3.57-2.77c-.98.66-2.23 1.06-3.71 1.06-2.86 0-5.29-1.93-6.16-4.53H2.18v2.84C3.99 20.53 7.7 23 12 23z"/>
            <path fill="#FBBC05" d="M5.84 14.09c-.22-.66-.35-1.36-.35-2.09s.13-1.43.35-2.09V7.07H2.18C1.43 8.55 1 10.22 1 12s.43 3.45 1.18 4.93l2.85-2.22.81-.62z"/>
            <path fill="#EA4335" d="M12 5.38c1.62 0 3.06.56 4.21 1.64l3.15-3.15C17.45 2.09 14.97 1 12 1 7.7 1 3.99 3.47 2.18 7.07l3.66 2.84c.87-2.6 3.3-4.53 6.16-4.53z"/>
          </svg>
          <span>Continue with Google</span>
        </button>

        <div className="relative mb-6">
          <div className="absolute inset-0 flex items-center">
            <div className="w-full border-t border-gray-200"></div>
          </div>
          <div className="relative flex justify-center text-sm">
            <span className="px-4 bg-gradient-to-br from-primary-50 to-accent-50 text-gray-500">Or continue with email</span>
          </div>
        </div>

        <div className="space-y-4 mb-6">
          <div className="relative">
            <Mail className="absolute left-3 top-1/2 transform -translate-y-1/2 w-5 h-5 text-gray-400" />
            <input
              type="email"
              placeholder="University email"
              value={email}
              onChange={(e) => setEmail(e.target.value)}
              className="w-full pl-10 pr-4 py-3 border border-gray-200 rounded-2xl focus:border-primary-500 focus:ring-2 focus:ring-primary-200 outline-none transition-all"
            />
          </div>

          <div className="relative">
            <Lock className="absolute left-3 top-1/2 transform -translate-y-1/2 w-5 h-5 text-gray-400" />
            <input
              type={showPassword ? 'text' : 'password'}
              placeholder="Password"
              value={password}
              onChange={(e) => setPassword(e.target.value)}
              className="w-full pl-10 pr-12 py-3 border border-gray-200 rounded-2xl focus:border-primary-500 focus:ring-2 focus:ring-primary-200 outline-none transition-all"
            />
            <button
              type="button"
              onClick={() => setShowPassword(!showPassword)}
              className="absolute right-3 top-1/2 transform -translate-y-1/2 text-gray-400 hover:text-gray-600"
            >
              {showPassword ? <EyeOff className="w-5 h-5" /> : <Eye className="w-5 h-5" />}
            </button>
          </div>
        </div>

        <button
          onClick={handleLogin}
          className="w-full bg-gradient-to-r from-primary-500 to-accent-500 text-white py-3 rounded-2xl font-semibold flex items-center justify-center space-x-2 hover:shadow-lg transition-all transform hover:scale-[1.02]"
        >
          <span>Sign In</span>
          <ArrowRight className="w-5 h-5" />
        </button>

        <div className="text-center mt-6">
          <button className="text-primary-600 hover:text-primary-700 font-medium">
            Forgot Password?
          </button>
        </div>

        <div className="text-center mt-8 pt-6 border-t border-gray-200">
          <p className="text-gray-600">
            Don't have an account?{' '}
            <button
              onClick={() => onNavigate('signup')}
              className="text-primary-600 hover:text-primary-700 font-semibold"
            >
              Sign Up
            </button>
          </p>
        </div>
      </div>
    </div>
  );
};