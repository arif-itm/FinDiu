import { Transaction, SavingsGoal, Reminder, ChatMessage } from '../types';

export const mockTransactions: Transaction[] = [
  {
    id: '1',
    amount: -25000,
    description: 'Spring Semester Tuition',
    category: 'Education',
    date: '2024-01-15',
    type: 'expense',
    icon: 'GraduationCap'
  },
  {
    id: '2',
    amount: 2500,
    description: 'Part-time Campus Job',
    category: 'Income',
    date: '2024-01-14',
    type: 'income',
    icon: 'Briefcase'
  },
  {
    id: '3',
    amount: -1200,
    description: 'Semester Registration Fee',
    category: 'Education',
    date: '2024-01-13',
    type: 'expense',
    icon: 'FileText'
  },
  {
    id: '4',
    amount: -150,
    description: 'Campus Coffee Shop',
    category: 'Food',
    date: '2024-01-12',
    type: 'expense',
    icon: 'Coffee'
  },
  {
    id: '5',
    amount: -500,
    description: 'One Card Top-up',
    category: 'Campus',
    date: '2024-01-11',
    type: 'expense',
    icon: 'CreditCard'
  },
  {
    id: '6',
    amount: -800,
    description: 'Green Garden Cafeteria',
    category: 'Food',
    date: '2024-01-10',
    type: 'expense',
    icon: 'Utensils'
  },
  {
    id: '7',
    amount: -300,
    description: 'Midterm Exam Fee',
    category: 'Education',
    date: '2024-01-09',
    type: 'expense',
    icon: 'BookOpen'
  },
  {
    id: '8',
    amount: -400,
    description: 'Final Exam Fee',
    category: 'Education',
    date: '2024-01-08',
    type: 'expense',
    icon: 'Award'
  }
];

export const mockSavingsGoals: SavingsGoal[] = [
  {
    id: '1',
    title: 'Next Semester Tuition',
    targetAmount: 25000,
    currentAmount: 18500,
    deadline: '2024-06-30',
    category: 'Education',
    color: 'bg-blue-500'
  },
  {
    id: '2',
    title: 'Laptop for Studies',
    targetAmount: 45000,
    currentAmount: 28000,
    deadline: '2024-08-15',
    category: 'Technology',
    color: 'bg-purple-500'
  },
  {
    id: '3',
    title: 'Study Abroad Program',
    targetAmount: 150000,
    currentAmount: 45000,
    deadline: '2024-12-31',
    category: 'Education',
    color: 'bg-green-500'
  },
  {
    id: '4',
    title: 'Campus Emergency Fund',
    targetAmount: 10000,
    currentAmount: 6500,
    deadline: '2024-05-30',
    category: 'Emergency',
    color: 'bg-orange-500'
  }
];

export const mockReminders: Reminder[] = [
  {
    id: '1',
    title: 'Fall Semester Tuition Due',
    amount: 25000,
    dueDate: '2024-02-15',
    type: 'payment',
    isCompleted: false
  },
  {
    id: '2',
    title: 'Dormitory Rent Payment',
    amount: 8000,
    dueDate: '2024-02-01',
    type: 'bill',
    isCompleted: true
  },
  {
    id: '3',
    title: 'Final Assignment Submission',
    amount: 0,
    dueDate: '2024-01-25',
    type: 'deadline',
    isCompleted: false
  },
  {
    id: '4',
    title: 'One Card Renewal',
    amount: 500,
    dueDate: '2024-02-10',
    type: 'payment',
    isCompleted: false
  },
  {
    id: '5',
    title: 'Library Book Return',
    amount: 0,
    dueDate: '2024-01-28',
    type: 'deadline',
    isCompleted: false
  }
];

export const mockChatMessages: ChatMessage[] = [
  {
    id: '1',
    message: 'Hi! I\'m your campus financial assistant. I can help you manage tuition, campus expenses, and student budgets. How can I help you today?',
    isUser: false,
    timestamp: '2024-01-20T10:00:00Z'
  },
  {
    id: '2',
    message: 'Can I afford to eat at Green Garden every day this month?',
    isUser: true,
    timestamp: '2024-01-20T10:01:00Z'
  },
  {
    id: '3',
    message: 'Based on your spending pattern, eating at Green Garden daily would cost around ৳2,400/month. With your current budget, I recommend limiting it to 3-4 times per week and using your One Card for discounts. This would save you ৳800-1,000 monthly!',
    isUser: false,
    timestamp: '2024-01-20T10:01:30Z'
  }
];