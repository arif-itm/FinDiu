import React, { useEffect } from 'react';
import { Wallet, TrendingUp, Shield } from 'lucide-react';

interface SplashScreenProps {
  onComplete: () => void;
}

export const SplashScreen: React.FC<SplashScreenProps> = ({ onComplete }) => {
  useEffect(() => {
    const timer = setTimeout(() => {
      onComplete();
    }, 3000);

    return () => clearTimeout(timer);
  }, [onComplete]);

  return (
    <div className="min-h-screen bg-gradient-to-br from-primary-500 via-accent-500 to-secondary-500 flex flex-col items-center justify-center text-white px-6">
      <div className="animate-bounce-gentle mb-8">
        <div className="relative">
          <div className="w-24 h-24 bg-white/20 rounded-3xl flex items-center justify-center backdrop-blur-sm">
            <Wallet className="w-12 h-12 text-white" />
          </div>
          <div className="absolute -top-2 -right-2 w-6 h-6 bg-secondary-400 rounded-full flex items-center justify-center">
            <TrendingUp className="w-3 h-3 text-white" />
          </div>
        </div>
      </div>

      <h1 className="text-4xl font-bold mb-2 animate-fade-in">FinDiu</h1>
      <p className="text-lg opacity-90 text-center mb-12 animate-fade-in">
        Smart Banking for Smart Students
      </p>

      <div className="flex space-x-8 animate-slide-up">
        <div className="flex flex-col items-center">
          <div className="w-12 h-12 bg-white/20 rounded-2xl flex items-center justify-center backdrop-blur-sm mb-2">
            <Shield className="w-6 h-6 text-white" />
          </div>
          <span className="text-sm opacity-80">Secure</span>
        </div>
        <div className="flex flex-col items-center">
          <div className="w-12 h-12 bg-white/20 rounded-2xl flex items-center justify-center backdrop-blur-sm mb-2">
            <TrendingUp className="w-6 h-6 text-white" />
          </div>
          <span className="text-sm opacity-80">Smart</span>
        </div>
        <div className="flex flex-col items-center">
          <div className="w-12 h-12 bg-white/20 rounded-2xl flex items-center justify-center backdrop-blur-sm mb-2">
            <Wallet className="w-6 h-6 text-white" />
          </div>
          <span className="text-sm opacity-80">Simple</span>
        </div>
      </div>

      <div className="absolute bottom-8 flex space-x-2">
        <div className="w-2 h-2 bg-white/60 rounded-full animate-pulse"></div>
        <div className="w-2 h-2 bg-white/40 rounded-full animate-pulse" style={{ animationDelay: '0.2s' }}></div>
        <div className="w-2 h-2 bg-white/60 rounded-full animate-pulse" style={{ animationDelay: '0.4s' }}></div>
      </div>
    </div>
  );
};