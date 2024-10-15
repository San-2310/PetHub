import mongoose from 'mongoose';

const eventSchema = new mongoose.Schema({
  petId: {
    type: mongoose.Schema.Types.ObjectId,
    ref: 'Pet',
    required: true
  },
  eventType: {
    type: String,
    required: true,
    enum: ['Vet Appointment', 'Grooming', 'Vaccination', 'Cremation']
  },
  title: {
    type: String,
    required: true,
    trim: true
  },
  startDate: {
    type: Date,
    required: true
  },
  endDate: {
    type: Date
  },
  notes: {
    type: String,
    trim: true
  },
  reminder: {
    type: Boolean,
    default: false
  },
  reminderTime: {
    type: Number, // minutes before the event
    default: 30
  },
  recurring: {
    type: Boolean,
    default: false
  },
  recurrencePattern: {
    type: String,
    enum: ['daily', 'weekly', 'monthly', 'yearly']
  },
  recurrenceEndDate: {
    type: Date
  },
  createdBy: {
    type: mongoose.Schema.Types.ObjectId,
    ref: 'User',
    required: true
  },
  createdAt: {
    type: Date,
    default: Date.now
  },
  updatedAt: {
    type: Date,
    default: Date.now
  }
}, { timestamps: true });

const Event = mongoose.model('Event', eventSchema);

export default Event;