import React from 'react';
import { Home, PlusCircle, Target, MessageCircle, BarChart3 } from 'lucide-react';
import { Screen } from '../types';

interface BottomNavigationProps {
  currentScreen: Screen;
  onNavigate: (screen: Screen) => void;
}

export const BottomNavigation: React.FC<BottomNavigationProps> = ({ currentScreen, onNavigate }) => {
  const navItems = [
    { screen: 'dashboard' as Screen, icon: Home, label: 'Home' },
    { screen: 'add-expense' as Screen, icon: PlusCircle, label: 'Add' },
    { screen: 'savings' as Screen, icon: Target, label: 'Goals' },
    { screen: 'ai-chat' as Screen, icon: MessageCircle, label: 'AI Chat' },
    { screen: 'analytics' as Screen, icon: BarChart3, label: 'Analytics' },
  ];

  return (
    <div className="fixed bottom-0 left-0 right-0 bg-white border-t border-gray-200 px-6 py-4">
      <div className="flex justify-around">
        {navItems.map((item) => {
          const isActive = currentScreen === item.screen;
          return (
            <button
              key={item.screen}
              onClick={() => onNavigate(item.screen)}
              className={`flex flex-col items-center space-y-1 transition-colors ${
                isActive ? 'text-primary-600' : 'text-gray-400 hover:text-gray-600'
              }`}
            >
              <item.icon className={`w-6 h-6 ${isActive ? 'fill-current' : ''}`} />
              <span className="text-xs font-medium">{item.label}</span>
            </button>
          );
        })}
      </div>
    </div>
  );
};