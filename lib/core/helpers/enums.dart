// enum OrderStatus {
//   //استلام طلبات من العملاء
//   OrderPlaced,
//   OrderConfirmed,
//   Shipping,
//   CaptainArrived,
//   CaptainTakeClothes,
//   //استلام طلبات من المكوجي
//   ToVendor,
//   RestaurantOrder,
//   DelvReceived,
//   Delivered,
//   //
//   Rated,
//   CANCELLED,
//   //not used
//   CancelledShop,
//   //Home,
//   //Arrived,
// }

// String getBottonTitel(String status) {
//   if (status == OrderStatus.OrderConfirmed.name) {
//     return 'Go to the customer';
//   } else if (status == OrderStatus.Shipping.name) {
//     return "the client's location has been reached";
//   } else if (status == OrderStatus.CaptainArrived.name) {
//     return 'Pick up from the customer';
//   } else if (status == OrderStatus.CaptainTakeClothes.name) {
//     return 'Arrived at laundry';
//   } else if (status == OrderStatus.ToVendor.name) {
//     return 'Waiting for ironing to finish';
//   } else if (status == OrderStatus.RestaurantOrder.name) {
//     return 'Picked up from laundry';
//   } else if (status == OrderStatus.DelvReceived.name) {
//     return 'Deliver to customer';
//   } else if (status == OrderStatus.CANCELLED.name) {
//     return 'The customer canceled the order';
//   } else if (status == OrderStatus.CancelledShop.name) {
//     return 'The ironer canceled the order';
//   } else if (status == OrderStatus.Rated.name) {
//     return 'The order has been rated by the user.';
//   } else {
//     return status;
//   }
// }

// String getOrderStatus(String status) {
//   if (status == OrderStatus.OrderPlaced.name) {
//     return 'Order started';
//   } else if (status == OrderStatus.OrderConfirmed.name) {
//     return 'Order started';
//   } else if (status == OrderStatus.Shipping.name) {
//     return 'On the way to the customer';
//   } else if (status == OrderStatus.CaptainArrived.name) {
//     return 'Arrived at the customer';
//   } else if (status == OrderStatus.CaptainTakeClothes.name) {
//     return 'Picked up from the customer';
//   } else if (status == OrderStatus.ToVendor.name) {
//     return 'Being ironed';
//   } else if (status == OrderStatus.RestaurantOrder.name) {
//     return 'Ironing done, waiting for you';
//   } else if (status == OrderStatus.DelvReceived.name) {
//     return 'Picked up and on the way to the customer';
//   } else if (status == OrderStatus.Delivered.name) {
//     return 'Order delivered successfully';
//   } else if (status == OrderStatus.Rated.name) {
//     return 'The order has been rated by the user.';
//   } else {
//     return status;
//   }
// }

// // enum DeliveryStatus { accepted, rejected, delivered, received }
// //
// // enum FastOrderStatus { Started, CANCELLED, Accepted, Received, Delivered }

// enum PlaceType { restaurant, superMarket }

// enum MapService { unKnown, google }
