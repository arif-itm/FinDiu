import React, { useState } from 'react';
import { Mail, Lock, User, GraduationCap, Eye, EyeOff, ArrowRight } from 'lucide-react';
import { Screen } from '../types';

interface SignupScreenProps {
  onNavigate: (screen: Screen) => void;
}

export const SignupScreen: React.FC<SignupScreenProps> = ({ onNavigate }) => {
  const [formData, setFormData] = useState({
    name: '',
    email: '',
    studentId: '',
    university: '',
    password: '',
    confirmPassword: ''
  });
  const [showPassword, setShowPassword] = useState(false);

  const handleSignup = () => {
    // Simulate signup
    onNavigate('dashboard');
  };

  return (
    <div className="min-h-screen bg-gradient-to-br from-secondary-50 to-primary-50 flex flex-col px-6 py-8">
      <div className="flex-1 flex flex-col justify-center max-w-sm mx-auto w-full">
        <div className="text-center mb-8">
          <h1 className="text-3xl font-bold text-gray-900 mb-2">Join FinDiu</h1>
          <p className="text-gray-600">Create your student banking account</p>
        </div>

        <div className="space-y-4 mb-6">
          <div className="relative">
            <User className="absolute left-3 top-1/2 transform -translate-y-1/2 w-5 h-5 text-gray-400" />
            <input
              type="text"
              placeholder="Full Name"
              value={formData.name}
              onChange={(e) => setFormData({...formData, name: e.target.value})}
              className="w-full pl-10 pr-4 py-3 border border-gray-200 rounded-2xl focus:border-secondary-500 focus:ring-2 focus:ring-secondary-200 outline-none transition-all"
            />
          </div>

          <div className="relative">
            <Mail className="absolute left-3 top-1/2 transform -translate-y-1/2 w-5 h-5 text-gray-400" />
            <input
              type="email"
              placeholder="University email"
              value={formData.email}
              onChange={(e) => setFormData({...formData, email: e.target.value})}
              className="w-full pl-10 pr-4 py-3 border border-gray-200 rounded-2xl focus:border-secondary-500 focus:ring-2 focus:ring-secondary-200 outline-none transition-all"
            />
          </div>

          <div className="relative">
            <GraduationCap className="absolute left-3 top-1/2 transform -translate-y-1/2 w-5 h-5 text-gray-400" />
            <input
              type="text"
              placeholder="Student ID"
              value={formData.studentId}
              onChange={(e) => setFormData({...formData, studentId: e.target.value})}
              className="w-full pl-10 pr-4 py-3 border border-gray-200 rounded-2xl focus:border-secondary-500 focus:ring-2 focus:ring-secondary-200 outline-none transition-all"
            />
          </div>

          <div className="relative">
            <Lock className="absolute left-3 top-1/2 transform -translate-y-1/2 w-5 h-5 text-gray-400" />
            <input
              type={showPassword ? 'text' : 'password'}
              placeholder="Password"
              value={formData.password}
              onChange={(e) => setFormData({...formData, password: e.target.value})}
              className="w-full pl-10 pr-12 py-3 border border-gray-200 rounded-2xl focus:border-secondary-500 focus:ring-2 focus:ring-secondary-200 outline-none transition-all"
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
          onClick={handleSignup}
          className="w-full bg-gradient-to-r from-secondary-500 to-primary-500 text-white py-3 rounded-2xl font-semibold flex items-center justify-center space-x-2 hover:shadow-lg transition-all transform hover:scale-[1.02]"
        >
          <span>Create Account</span>
          <ArrowRight className="w-5 h-5" />
        </button>

        <div className="text-center mt-8 pt-6 border-t border-gray-200">
          <p className="text-gray-600">
            Already have an account?{' '}
            <button
              onClick={() => onNavigate('login')}
              className="text-secondary-600 hover:text-secondary-700 font-semibold"
            >
              Sign In
            </button>
          </p>
        </div>
      </div>
    </div>
  );
};