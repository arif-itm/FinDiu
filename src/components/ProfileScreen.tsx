import React from 'react';
import { ArrowLeft, User, Bell, Shield, HelpCircle, LogOut, ChevronRight, Edit, Info } from 'lucide-react';
import { Screen } from '../types';

interface ProfileScreenProps {
  onNavigate: (screen: Screen) => void;
}

export const ProfileScreen: React.FC<ProfileScreenProps> = ({ onNavigate }) => {
  const menuItems = [
    { icon: Edit, label: 'Edit Profile', color: 'text-blue-600', action: () => onNavigate('profile-edit') },
    { icon: Bell, label: 'Notifications', color: 'text-blue-600', action: () => {} },
    { icon: Shield, label: 'Security', color: 'text-green-600', action: () => {} },
    { icon: Info, label: 'About Us', color: 'text-purple-600', action: () => onNavigate('about') },
    { icon: HelpCircle, label: 'Help & Support', color: 'text-orange-600', action: () => {} },
    { icon: LogOut, label: 'Sign Out', color: 'text-red-600', action: () => onNavigate('login') },
  ];

  return (
    <div className="min-h-screen bg-gray-50">
      {/* Header */}
      <div className="bg-gradient-to-r from-accent-500 to-primary-500 px-6 py-4 text-white">
        <div className="flex items-center space-x-4 mb-6">
          <button
            onClick={() => onNavigate('dashboard')}
            className="w-10 h-10 bg-white/20 rounded-2xl flex items-center justify-center hover:bg-white/30 transition-colors backdrop-blur-sm"
          >
            <ArrowLeft className="w-5 h-5" />
          </button>
          <h1 className="text-xl font-bold">Profile</h1>
        </div>

        {/* Profile Info */}
        <div className="bg-white/10 backdrop-blur-sm rounded-3xl p-6">
          <div className="flex items-center justify-between">
            <div className="flex items-center space-x-4">
              <div className="w-16 h-16 bg-white/20 rounded-full flex items-center justify-center backdrop-blur-sm">
                <User className="w-8 h-8" />
              </div>
              <div>
                <h2 className="text-xl font-bold">Md Ariful Islam</h2>
                <p className="text-sm opacity-80">arif-itm@diu.edu.bd</p>
                <p className="text-sm opacity-80">Student ID: 1234567890</p>
              </div>
            </div>
            <button
              onClick={() => onNavigate('profile-edit')}
              className="bg-white/20 backdrop-blur-sm p-3 rounded-2xl hover:bg-white/30 transition-colors"
            >
              <Edit className="w-5 h-5" />
            </button>
          </div>
        </div>
      </div>

      <div className="px-6 -mt-6 pb-6">
        {/* Stats Cards */}
        <div className="grid grid-cols-2 gap-4 mb-6">
          <div className="bg-white rounded-3xl p-6 shadow-sm text-center">
            <h3 className="text-2xl font-bold text-gray-900">156</h3>
            <p className="text-sm text-gray-600">Campus Transactions</p>
          </div>
          <div className="bg-white rounded-3xl p-6 shadow-sm text-center">
            <h3 className="text-2xl font-bold text-gray-900">4</h3>
            <p className="text-sm text-gray-600">Savings Goals</p>
          </div>
        </div>

        {/* Account Info */}
        <div className="bg-white rounded-3xl p-6 shadow-sm mb-6">
          <h3 className="text-lg font-semibold text-gray-900 mb-4">Campus Information</h3>
          <div className="space-y-4">
            <div className="flex justify-between items-center">
              <span className="text-gray-600">University</span>
              <span className="font-medium text-gray-900">Daffodil International University</span>
            </div>
            <div className="flex justify-between items-center">
              <span className="text-gray-600">Program</span>
              <span className="font-medium text-gray-900">Information Technology & Management</span>
            </div>
            <div className="flex justify-between items-center">
              <span className="text-gray-600">Year</span>
              <span className="font-medium text-gray-900">3rd Year</span>
            </div>
            <div className="flex justify-between items-center">
              <span className="text-gray-600">Member Since</span>
              <span className="font-medium text-gray-900">Jan 2024</span>
            </div>
          </div>
        </div>

        {/* Menu Items */}
        <div className="bg-white rounded-3xl shadow-sm overflow-hidden">
          {menuItems.map((item, index) => (
            <button
              key={item.label}
              onClick={item.action}
              className={`w-full flex items-center justify-between p-6 hover:bg-gray-50 transition-colors ${
                index < menuItems.length - 1 ? 'border-b border-gray-100' : ''
              }`}
            >
              <div className="flex items-center space-x-4">
                <item.icon className={`w-6 h-6 ${item.color}`} />
                <span className="font-medium text-gray-900">{item.label}</span>
              </div>
              <ChevronRight className="w-5 h-5 text-gray-400" />
            </button>
          ))}
        </div>

        {/* App Version */}
        <div className="text-center mt-8 text-gray-500 text-sm">
          FinDiu v1.0.0 - Campus Banking for Students
        </div>
      </div>
    </div>
  );
};