import mongoose from 'mongoose';

// MongoDB connection URL
const connectDB = async () => {
    console.log(process.env.MONGODB_URI);
    try {
        const connection = await mongoose.connect(process.env.MONGODB_URI , {
            useNewUrlParser: true,
            useUnifiedTopology: true,
        });
        console.log(`MongoDB connected: ${connection.connection.host}`);
    } catch (error) {
        console.error("MongoDB connection failed:", error.message);
        process.exit(1);
    }
};

export default connectDB;
