import React from 'react';
import { ArrowLeft, Wallet, Shield, Users, Target, Heart, Award } from 'lucide-react';
import { Screen } from '../types';

interface AboutScreenProps {
  onNavigate: (screen: Screen) => void;
}

export const AboutScreen: React.FC<AboutScreenProps> = ({ onNavigate }) => {
  const features = [
    {
      icon: Wallet,
      title: 'Smart Campus Banking',
      description: 'Designed specifically for university students with campus-focused features'
    },
    {
      icon: Shield,
      title: 'Secure & Safe',
      description: 'Bank-level security to protect your financial data and transactions'
    },
    {
      icon: Target,
      title: 'Goal-Oriented Savings',
      description: 'Set and achieve financial goals like tuition, books, and emergency funds'
    },
    {
      icon: Users,
      title: 'Student Community',
      description: 'Built by students, for students - we understand your unique needs'
    }
  ];

  const team = [
    { name: 'Md Ariful Islam', role: 'Founder & CTO', university: 'DIU' },
    { name: 'Md Shariful Islam', role: 'Founder & CEO', university: 'DIU' }
  ];

  return (
    <div className="min-h-screen bg-gray-50">
      {/* Header */}
      <div className="bg-gradient-to-r from-primary-500 to-accent-500 px-6 py-4 text-white">
        <div className="flex items-center space-x-4 mb-6">
          <button
            onClick={() => onNavigate('profile')}
            className="w-10 h-10 bg-white/20 rounded-2xl flex items-center justify-center hover:bg-white/30 transition-colors backdrop-blur-sm"
          >
            <ArrowLeft className="w-5 h-5" />
          </button>
          <h1 className="text-xl font-bold">About FinDiu</h1>
        </div>

        {/* Hero Section */}
        <div className="bg-white/10 backdrop-blur-sm rounded-3xl p-6 text-center">
          <div className="w-16 h-16 bg-white/20 rounded-full flex items-center justify-center mx-auto mb-4 backdrop-blur-sm">
            <Wallet className="w-8 h-8" />
          </div>
          <h2 className="text-2xl font-bold mb-2">Smart Banking for Smart Students</h2>
          <p className="text-sm opacity-90">Empowering university students across Bangladesh to take control of their finances</p>
        </div>
      </div>

      <div className="px-6 -mt-6 pb-6 space-y-6">
        {/* Mission Statement */}
        <div className="bg-white rounded-3xl p-6 shadow-sm">
          <div className="flex items-center space-x-3 mb-4">
            <Heart className="w-6 h-6 text-red-500" />
            <h3 className="text-lg font-semibold text-gray-900">Our Mission</h3>
          </div>
          <p className="text-gray-600 leading-relaxed">
            FinDiu was created to solve the unique financial challenges faced by university students in Bangladesh. 
            We understand the struggle of managing tuition fees, campus expenses, and daily budgets while pursuing education. 
            Our mission is to provide a simple, secure, and student-friendly platform that helps you achieve financial independence.
          </p>
        </div>

        {/* Features */}
        <div className="bg-white rounded-3xl p-6 shadow-sm">
          <h3 className="text-lg font-semibold text-gray-900 mb-6">Why Choose FinDiu?</h3>
          <div className="space-y-4">
            {features.map((feature, index) => (
              <div key={index} className="flex items-start space-x-4">
                <div className="w-12 h-12 bg-primary-100 rounded-2xl flex items-center justify-center flex-shrink-0">
                  <feature.icon className="w-6 h-6 text-primary-600" />
                </div>
                <div>
                  <h4 className="font-semibold text-gray-900 mb-1">{feature.title}</h4>
                  <p className="text-sm text-gray-600">{feature.description}</p>
                </div>
              </div>
            ))}
          </div>
        </div>

        {/* Statistics */}
        <div className="bg-white rounded-3xl p-6 shadow-sm">
          <h3 className="text-lg font-semibold text-gray-900 mb-6">Our Impact</h3>
          <div className="grid grid-cols-2 gap-6">
            <div className="text-center">
              <div className="text-3xl font-bold text-primary-600 mb-1">10K+</div>
              <div className="text-sm text-gray-600">Active Students</div>
            </div>
            <div className="text-center">
              <div className="text-3xl font-bold text-secondary-600 mb-1">50+</div>
              <div className="text-sm text-gray-600">Sponsors</div>
            </div>
            <div className="text-center">
              <div className="text-3xl font-bold text-accent-600 mb-1">৳2Cr+</div>
              <div className="text-sm text-gray-600">Money Managed</div>
            </div>
            <div className="text-center">
              <div className="text-3xl font-bold text-orange-600 mb-1">95%</div>
              <div className="text-sm text-gray-600">Satisfaction Rate</div>
            </div>
          </div>
        </div>

        {/* Team */}
        <div className="bg-white rounded-3xl p-6 shadow-sm">
          <div className="flex items-center space-x-3 mb-6">
            <Award className="w-6 h-6 text-yellow-500" />
            <h3 className="text-lg font-semibold text-gray-900">Meet Our Team</h3>
          </div>
          <div className="space-y-4">
            {team.map((member, index) => (
              <div key={index} className="flex items-center space-x-4">
                <div className="w-12 h-12 bg-gradient-to-r from-primary-500 to-accent-500 rounded-full flex items-center justify-center text-white font-semibold">
                  {member.name.split(' ').map(n => n[0]).join('')}
                </div>
                <div>
                  <div className="font-semibold text-gray-900">{member.name}</div>
                  <div className="text-sm text-gray-600">{member.role} • {member.university}</div>
                </div>
              </div>
            ))}
          </div>
        </div>

        {/* Contact */}
        <div className="bg-white rounded-3xl p-6 shadow-sm">
          <h3 className="text-lg font-semibold text-gray-900 mb-4">Get in Touch</h3>
          <div className="space-y-3 text-sm text-gray-600">
            <div>📧 support@findiu.com.bd</div>
            <div>📱 +880 1700-000000</div>
            <div>🏢 Dhaka, Bangladesh</div>
            <div>🌐 www.findiu.com.bd</div>
          </div>
        </div>

        {/* Version */}
        <div className="text-center text-gray-500 text-sm">
          FinDiu v1.0.0 • Made with ❤️ for Bangladeshi Students
        </div>
      </div>
    </div>
  );
};