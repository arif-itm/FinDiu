export interface User {
  id: string;
  name: string;
  email: string;
  studentId: string;
  university: string;
  avatar?: string;
}

export interface Transaction {
  id: string;
  amount: number;
  description: string;
  category: string;
  date: string;
  type: 'income' | 'expense';
  icon: string;
}

export interface SavingsGoal {
  id: string;
  title: string;
  targetAmount: number;
  currentAmount: number;
  deadline: string;
  category: string;
  color: string;
}

export interface Reminder {
  id: string;
  title: string;
  amount: number;
  dueDate: string;
  type: 'bill' | 'payment' | 'deadline';
  isCompleted: boolean;
}

export interface ChatMessage {
  id: string;
  message: string;
  isUser: boolean;
  timestamp: string;
}

export type Screen = 
  | 'splash'
  | 'login'
  | 'signup'
  | 'dashboard'
  | 'add-expense'
  | 'savings'
  | 'reminders'
  | 'ai-chat'
  | 'analytics'
  | 'profile'
  | 'profile-edit'
  | 'about'
  | 'transactions';