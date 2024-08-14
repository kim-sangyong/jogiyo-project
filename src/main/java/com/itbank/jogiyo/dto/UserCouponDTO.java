package com.itbank.jogiyo.dto;

public class UserCouponDTO {
   private int usercid;
   private int couponid;
   private String id;
   private String indate;
   private String couname;
   private String coucontent;
   private String storeid;
   private String storename;
   
   public String getStorename() {
      return storename;
   }
   public void setStorename(String storename) {
      this.storename = storename;
   }
   public String getStoreid() {
      return storeid;
   }
   public void setStoreid(String storeid) {
      this.storeid = storeid;
   }
   public String getCouname() {
      return couname;
   }
   public void setCouname(String couname) {
      this.couname = couname;
   }
   public String getCoucontent() {
      return coucontent;
   }
   public void setCoucontent(String coucontent) {
      this.coucontent = coucontent;
   }
   public int getUsercid() {
      return usercid;
   }
   public void setUsercid(int usercid) {
      this.usercid = usercid;
   }
   public int getCouponid() {
      return couponid;
   }
   public void setCouponid(int couponid) {
      this.couponid = couponid;
   }
   public String getId() {
      return id;
   }
   public void setId(String id) {
      this.id = id;
   }
   public String getIndate() {
      return indate;
   }
   public void setIndate(String indate) {
      this.indate = indate;
   }

}