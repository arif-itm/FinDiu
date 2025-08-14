# Signup Fields Storage Test

## Test Case: Complete User Registration

### Expected Behavior:
When a user signs up with the following information:
- **Name**: "John Doe"
- **Email**: "john.doe@example.com"
- **Password**: "test123"
- **Student ID**: "12345"
- **University**: "Example University"

### Expected Firestore Document:
```json
{
  "id": "[user_uid]",
  "name": "John Doe",
  "email": "john.doe@example.com",
  "studentId": "12345",
  "university": "Example University",
  "avatar": null,
  "createdAt": "[timestamp]",
  "updatedAt": "[timestamp]"
}
```

### Data Flow:
1. **Signup Screen** → Collects: name, email, password, studentId, university
2. **AuthProvider.registerWithEmailPassword()** → Passes: email, password, name, studentId, university
3. **AuthService.registerWithEmailPassword()** → Passes: email, password, name, studentId, university
4. **AuthService._createUserDocument()** → Creates User model and saves to Firestore

### Updated Code Changes:
- ✅ Updated `AuthService.registerWithEmailPassword()` to accept optional `studentId` and `university`
- ✅ Updated `AuthService._createUserDocument()` to use provided `studentId` and `university`
- ✅ Updated `AuthProvider.registerWithEmailPassword()` to pass `studentId` and `university`
- ✅ Updated signup screen to pass `studentId` and `university` from form controllers
- ✅ Changed placeholder text from "Full Name" to "Name"

### Test Steps:
1. Run the app
2. Navigate to signup screen
3. Fill in all fields (including Student ID and University)
4. Submit the form
5. Check Firestore console to verify all fields are stored

### Status: 
✅ **READY FOR TESTING** - All code changes implemented
