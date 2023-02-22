using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using KimDongBookStore.Models;

namespace KimDongBookStore.Models
{
    public class GioHang
    {
        KimDongBookStoreDataContext db = new KimDongBookStoreDataContext();

        public int iMaSach { get; set; }
        public string sTenSach { get; set; }
        public string sAnhBia { get; set; }
        public decimal dDonGia { get; set; }
        public int iSoLuong { get; set; }
        public decimal dThanhTien
        {
            get { return iSoLuong * dDonGia; }
        }

        public GioHang(int id)
        {
            iMaSach = id;
            SACH sach = db.SACHes.Single(a => a.MASACH == iMaSach);
            sTenSach = sach.TENSACH;
            sAnhBia = sach.ANHBIA;
            dDonGia = sach.GIABAN;
            iSoLuong = 1;
        }
    }
}