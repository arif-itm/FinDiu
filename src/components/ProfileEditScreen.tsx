import React, { useState } from 'react';
import { ArrowLeft, User, Mail, GraduationCap, Phone, MapPin, Save, Camera } from 'lucide-react';
import { Screen } from '../types';

interface ProfileEditScreenProps {
  onNavigate: (screen: Screen) => void;
}

export const ProfileEditScreen: React.FC<ProfileEditScreenProps> = ({ onNavigate }) => {
  const [formData, setFormData] = useState({
    name: 'Md Ariful Islam',
    email: 'arif-itm@diu.edu.bd',
    phone: '+880 1700-123456',
    studentId: '1234567890',
    university: 'Daffodil International University',
    program: 'Information Technology & Management',
    year: '3rd Year',
    address: 'Dhaka, Bangladesh'
  });

  const [showSuccess, setShowSuccess] = useState(false);

  const handleSave = () => {
    setShowSuccess(true);
    setTimeout(() => {
      setShowSuccess(false);
      onNavigate('profile');
    }, 1500);
  };

  const handlePhotoChange = () => {
    // Simulate photo change
    alert('Photo change functionality would be implemented here');
  };

  if (showSuccess) {
    return (
      <div className="min-h-screen bg-gradient-to-br from-secondary-500 to-primary-500 flex items-center justify-center">
        <div className="text-center text-white">
          <div className="w-20 h-20 bg-white/20 rounded-full flex items-center justify-center mx-auto mb-4 backdrop-blur-sm">
            <Save className="w-10 h-10" />
          </div>
          <h2 className="text-2xl font-bold mb-2">Profile Updated!</h2>
          <p className="text-lg opacity-90">Your information has been saved successfully</p>
        </div>
      </div>
    );
  }

  return (
    <div className="min-h-screen bg-gray-50">
      {/* Header */}
      <div className="bg-gradient-to-r from-accent-500 to-primary-500 px-6 py-4 text-white">
        <div className="flex items-center justify-between mb-6">
          <div className="flex items-center space-x-4">
            <button
              onClick={() => onNavigate('profile')}
              className="w-10 h-10 bg-white/20 rounded-2xl flex items-center justify-center hover:bg-white/30 transition-colors backdrop-blur-sm"
            >
              <ArrowLeft className="w-5 h-5" />
            </button>
            <h1 className="text-xl font-bold">Edit Profile</h1>
          </div>
          <button
            onClick={handleSave}
            className="bg-white/20 backdrop-blur-sm px-4 py-2 rounded-2xl font-medium hover:bg-white/30 transition-colors"
          >
            Save
          </button>
        </div>

        {/* Profile Picture */}
        <div className="bg-white/10 backdrop-blur-sm rounded-3xl p-6 text-center">
          <div className="relative inline-block">
            <div className="w-20 h-20 bg-white/20 rounded-full flex items-center justify-center backdrop-blur-sm">
              <User className="w-10 h-10" />
            </div>
            <button 
              onClick={handlePhotoChange}
              className="absolute -bottom-2 -right-2 w-8 h-8 bg-primary-500 rounded-full flex items-center justify-center hover:bg-primary-600 transition-colors"
            >
              <Camera className="w-4 h-4 text-white" />
            </button>
          </div>
          <p className="text-sm opacity-80 mt-2">Tap to change photo</p>
        </div>
      </div>

      <div className="px-6 -mt-6 pb-6 space-y-6">
        {/* Personal Information */}
        <div className="bg-white rounded-3xl p-6 shadow-sm">
          <h3 className="text-lg font-semibold text-gray-900 mb-4">Personal Information</h3>
          <div className="space-y-4">
            <div className="relative">
              <User className="absolute left-3 top-1/2 transform -translate-y-1/2 w-5 h-5 text-gray-400" />
              <input
                type="text"
                placeholder="Full Name"
                value={formData.name}
                onChange={(e) => setFormData({...formData, name: e.target.value})}
                className="w-full pl-10 pr-4 py-3 border border-gray-200 rounded-2xl focus:border-primary-500 focus:ring-2 focus:ring-primary-200 outline-none transition-all"
              />
            </div>

            <div className="relative">
              <Mail className="absolute left-3 top-1/2 transform -translate-y-1/2 w-5 h-5 text-gray-400" />
              <input
                type="email"
                placeholder="Email Address"
                value={formData.email}
                onChange={(e) => setFormData({...formData, email: e.target.value})}
                className="w-full pl-10 pr-4 py-3 border border-gray-200 rounded-2xl focus:border-primary-500 focus:ring-2 focus:ring-primary-200 outline-none transition-all"
              />
            </div>

            <div className="relative">
              <Phone className="absolute left-3 top-1/2 transform -translate-y-1/2 w-5 h-5 text-gray-400" />
              <input
                type="tel"
                placeholder="Phone Number"
                value={formData.phone}
                onChange={(e) => setFormData({...formData, phone: e.target.value})}
                className="w-full pl-10 pr-4 py-3 border border-gray-200 rounded-2xl focus:border-primary-500 focus:ring-2 focus:ring-primary-200 outline-none transition-all"
              />
            </div>

            <div className="relative">
              <MapPin className="absolute left-3 top-1/2 transform -translate-y-1/2 w-5 h-5 text-gray-400" />
              <input
                type="text"
                placeholder="Address"
                value={formData.address}
                onChange={(e) => setFormData({...formData, address: e.target.value})}
                className="w-full pl-10 pr-4 py-3 border border-gray-200 rounded-2xl focus:border-primary-500 focus:ring-2 focus:ring-primary-200 outline-none transition-all"
              />
            </div>
          </div>
        </div>

        {/* Academic Information */}
        <div className="bg-white rounded-3xl p-6 shadow-sm">
          <h3 className="text-lg font-semibold text-gray-900 mb-4">Academic Information</h3>
          <div className="space-y-4">
            <div className="relative">
              <GraduationCap className="absolute left-3 top-1/2 transform -translate-y-1/2 w-5 h-5 text-gray-400" />
              <input
                type="text"
                placeholder="Student ID"
                value={formData.studentId}
                onChange={(e) => setFormData({...formData, studentId: e.target.value})}
                className="w-full pl-10 pr-4 py-3 border border-gray-200 rounded-2xl focus:border-primary-500 focus:ring-2 focus:ring-primary-200 outline-none transition-all"
              />
            </div>

            <input
              type="text"
              placeholder="University"
              value={formData.university}
              onChange={(e) => setFormData({...formData, university: e.target.value})}
              className="w-full px-4 py-3 border border-gray-200 rounded-2xl focus:border-primary-500 focus:ring-2 focus:ring-primary-200 outline-none transition-all"
            />

            <input
              type="text"
              placeholder="Program/Major"
              value={formData.program}
              onChange={(e) => setFormData({...formData, program: e.target.value})}
              className="w-full px-4 py-3 border border-gray-200 rounded-2xl focus:border-primary-500 focus:ring-2 focus:ring-primary-200 outline-none transition-all"
            />

            <select
              value={formData.year}
              onChange={(e) => setFormData({...formData, year: e.target.value})}
              className="w-full px-4 py-3 border border-gray-200 rounded-2xl focus:border-primary-500 focus:ring-2 focus:ring-primary-200 outline-none transition-all"
            >
              <option value="1st Year">1st Year</option>
              <option value="2nd Year">2nd Year</option>
              <option value="3rd Year">3rd Year</option>
              <option value="4th Year">4th Year</option>
              <option value="Masters">Masters</option>
              <option value="PhD">PhD</option>
            </select>
          </div>
        </div>

        {/* Save Button */}
        <button
          onClick={handleSave}
          className="w-full bg-gradient-to-r from-primary-500 to-accent-500 text-white py-4 rounded-2xl font-semibold text-lg hover:shadow-lg transition-all transform hover:scale-[1.02]"
        >
          Save Changes
        </button>
      </div>
    </div>
  );
};