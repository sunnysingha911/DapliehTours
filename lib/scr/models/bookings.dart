class BookingListItems{
  String bookingId;
  String bookingName;
  String source;
  String destination;
  String payMode;
  String amount;
  String bimage;

  BookingListItems(
      this.bookingId,
      this.bookingName,
      this.source,
      this.destination,
      this.payMode,
      this.amount,
      this.bimage
   );
}

class BookingVehListItems{
  String modName;
  String vehNo;
  String type; 
  String amount; 
  String date; 
  String time; 
  String image; 
  String payMode; 
  String vehid;
  
  BookingVehListItems(
    this.modName, 
    this.vehNo, 
    this.type, 
    this.amount, 
    this.date, 
    this.time, 
    this.image, 
    this.payMode, 
    this.vehid
  );
}