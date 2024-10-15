import Order from "../models/order.model.js";
import { Product } from "../models/product.model.js";
import User from "../models/user.model.js";

const orderController = {
  addToCart: async (req, res) => {
    try {
      const { id } = req.body;
      const product = await Product.findById(id);
      let user = await User.findById(req.user);

      const existingProduct = user.cart.find((item) => 
        item.product._id.equals(product._id)
      );

      if (existingProduct) {
        existingProduct.quantity += 1;
      } else {
        user.cart.push({ product, quantity: 1 });
      }

      user = await user.save();
      res.json(user);
    } catch (e) {
      res.status(500).json({ error: e.message });
    }
  },

  removeFromCart: async (req, res) => {
    try {
      const { id } = req.params;
      const product = await Product.findById(id);
      let user = await User.findById(req.user);

      user.cart = user.cart.reduce((acc, item) => {
        if (item.product._id.equals(product._id)) {
          if (item.quantity > 1) {
            acc.push({ ...item, quantity: item.quantity - 1 });
          }
        } else {
          acc.push(item);
        }
        return acc;
      }, []);

      user = await user.save();
      res.json(user);
    } catch (e) {
      res.status(500).json({ error: e.message });
    }
  },

  saveUserAddress: async (req, res) => {
    try {
      const { address } = req.body;
      let user = await User.findById(req.user);
      user.address = address;
      user = await user.save();
      res.json(user);
    } catch (e) {
      res.status(500).json({ error: e.message });
    }
  },

  placeOrder: async (req, res) => {
    try {
      const { cart, totalPrice, address } = req.body;
      let products = [];

      for (let item of cart) {
        let product = await Product.findById(item.product._id);
        if (product.quantity >= item.quantity) {
          product.quantity -= item.quantity;
          products.push({ product, quantity: item.quantity });
          await product.save();
        } else {
          return res.status(400).json({ msg: `${product.name} is out of stock!` });
        }
      }

      let user = await User.findById(req.user);
      user.cart = [];
      user = await user.save();

      let order = new Order({
        products,
        totalPrice,
        address,
        userId: req.user,
        orderedAt: new Date().getTime(),
      });
      order = await order.save();
      res.json(order);
    } catch (e) {
      res.status(500).json({ error: e.message });
    }
  },

  getUserOrders: async (req, res) => {
    try {
      const orders = await Order.find({ userId: req.user });
      res.json(orders);
    } catch (e) {
      res.status(500).json({ error: e.message });
    }
  },
};

export default orderController;