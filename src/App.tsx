import React, { useState } from 'react';
import { Screen } from './types';
import { SplashScreen } from './components/SplashScreen';
import { LoginScreen } from './components/LoginScreen';
import { SignupScreen } from './components/SignupScreen';
import { DashboardScreen } from './components/DashboardScreen';
import { AddExpenseScreen } from './components/AddExpenseScreen';
import { SavingsScreen } from './components/SavingsScreen';
import { RemindersScreen } from './components/RemindersScreen';
import { AIChatScreen } from './components/AIChatScreen';
import { AnalyticsScreen } from './components/AnalyticsScreen';
import { ProfileScreen } from './components/ProfileScreen';
import { ProfileEditScreen } from './components/ProfileEditScreen';
import { AboutScreen } from './components/AboutScreen';
import { TransactionsScreen } from './components/TransactionsScreen';

function App() {
  const [currentScreen, setCurrentScreen] = useState<Screen>('splash');

  const handleNavigate = (screen: Screen) => {
    setCurrentScreen(screen);
  };

  const renderScreen = () => {
    switch (currentScreen) {
      case 'splash':
        return <SplashScreen onComplete={() => setCurrentScreen('login')} />;
      case 'login':
        return <LoginScreen onNavigate={handleNavigate} />;
      case 'signup':
        return <SignupScreen onNavigate={handleNavigate} />;
      case 'dashboard':
        return <DashboardScreen onNavigate={handleNavigate} />;
      case 'add-expense':
        return <AddExpenseScreen onNavigate={handleNavigate} />;
      case 'savings':
        return <SavingsScreen onNavigate={handleNavigate} />;
      case 'reminders':
        return <RemindersScreen onNavigate={handleNavigate} />;
      case 'ai-chat':
        return <AIChatScreen onNavigate={handleNavigate} />;
      case 'analytics':
        return <AnalyticsScreen onNavigate={handleNavigate} />;
      case 'profile':
        return <ProfileScreen onNavigate={handleNavigate} />;
      case 'profile-edit':
        return <ProfileEditScreen onNavigate={handleNavigate} />;
      case 'about':
        return <AboutScreen onNavigate={handleNavigate} />;
      case 'transactions':
        return <TransactionsScreen onNavigate={handleNavigate} />;
      default:
        return <DashboardScreen onNavigate={handleNavigate} />;
    }
  };

  return (
    <div className="min-h-screen bg-gray-50">
      {renderScreen()}
    </div>
  );
}

export default App;