using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using DoanWTT;
    public class ShoppingCart
    {
        // Lấy giỏ hàng từ Session
        public static ShoppingCart Cart
        {
            get
            {
                var cart = HttpContext.Current.Session["Cart"] as ShoppingCart;
                // Nếu chưa có giỏ hàng trong session -> tạo mới và lưu vào session
                if (cart == null)
                {
                    cart = new ShoppingCart();
                    HttpContext.Current.Session["Cart"] = cart;
                }
                return cart;
            }
        }

        // Chứa các mặt hàng đã chọn
        public List<sanPham> Items = new List<sanPham>();

        public void Add(string id)
        {
            try // tìm thấy trong giỏ -> tăng số lượng lên 1
            {
                var item = Items.Single(i => i.maSP == id);
                item.soLuong++;
            }
            catch // chưa có trong giỏ -> truy vấn CSDL và bỏ vào giỏ
            {
                var db = new BanHangOnlineEntities2();
                var item = db.sanPhams.Find(id);
                item.soLuong = 1;
                Items.Add(item);
            }
        }

        public void Remove(string id)
        {
            var item = Items.Single(i => i.maSP == id);
            Items.Remove(item);
        }

        public void Update(string id, int newsoLuong)
        {
            var item = Items.Single(i => i.maSP == id);
            item.soLuong = newsoLuong;
        }

        public void Clear()
        {
            Items.Clear();
        }

        public int Count
        {
            get
            {
                return Items.Count;
            }
        }

    public String Total
    {
        get
        {
            double Tong =Convert.ToDouble( Items.Sum(p => p.giaBan  * p.soLuong *( 1 - p.giamGia)));
           
          string  Tongrs =  Tong.ToString("#,##0VND") ;

            return Tongrs;
        }
    }
}
