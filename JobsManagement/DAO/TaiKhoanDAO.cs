﻿using JobsManagement.DTO;
using Microsoft.Win32;
using System;
using System.Collections.Generic;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Security.Principal;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;
using System.Windows.Markup;
using static System.Windows.Forms.VisualStyles.VisualStyleElement.StartPanel;

namespace JobsManagement.DAO
{
    internal class TaiKhoanDAO
    {
        private static TaiKhoanDAO instance;

        public static TaiKhoanDAO Instance
        {
            /*
            get { if (instance == null) instance = new TaiKhoanDAO(); return instance; }
            private set { instance = value; }
            */
            get
            {
                if (instance == null)
                {
                    instance = new TaiKhoanDAO();
                }
                return instance;
            }
        }
        public TaiKhoanDAO() { }

        //public TaiKhoan CurrentAcc(string username)
        //{
        //    DataTable data = DataProvider.Instance.truyVanCoKetQua("select * from taikhoan where tendangnhap ='" + username + "'");
        //    foreach (DataRow item in data.Rows)
        //    {
        //        return new TaiKhoan(item);
        //    }
        //    return null;
        //}


        /*
        public bool DKTK(string username, string password, string tenHT, string chbm, string tl)
        {
            bool kq = DataProvider.Instance.truyVanKTraVe(string.Format("insert into TaiKhoan(tenDangNhap, matKhau, tenHienThi, cauhoi, traLoi) values('{0}','{1}',N'{2}',N'{3}',N'{4}')",username,password,tenHT,chbm,tl));
            return kq;
        }
        */
        public bool signUp(string tenDN, string MK, string MK1, string tenHT, string cauHoi, string traLoi)
        {
            if (string.IsNullOrEmpty(tenDN) || MK != MK1 || string.IsNullOrEmpty(MK) || string.IsNullOrEmpty(tenHT) || string.IsNullOrEmpty(traLoi) || string.IsNullOrEmpty(cauHoi))
            {
                return false;
            }
            else
            {
                string query = "exec DangKy_1 @tenDN , @MK , @tenHT , @cauHoi , @traLoi ";
                return DataProvider.Instance.truyVanKTraVe(query, new object[] { tenDN, MK, tenHT, cauHoi, traLoi });
            }
        }

        public TaiKhoan CurrentAcc(string userName)
        {
            string query = "exec DangNhap_2 @userName ";
            DataTable data = DataProvider.Instance.truyVanCoKetQua(query, new object[] { userName });
            foreach (DataRow item in data.Rows)
            {
                return new TaiKhoan(item);
            }

            return null;
        }
        
        
        #region cai dat he thong
        public bool Login(string userName, string passWord)
        {
            string query = "exec DangNhap_1 @userName , @passWord ";
            DataTable data = DataProvider.Instance.truyVanCoKetQua(query, new object[] { userName, passWord });
            return data.Rows.Count > 0;
        }

        public void setKhoiDong(string userName, bool isOn)
        {
            if (isOn)
            {
                DataProvider.Instance.truyVanKTraVe("exec SetKD @i , @username", new object[] { 1, userName});

            }
            else DataProvider.Instance.truyVanKTraVe("exec SetKD @i , @username", new object[] { 0, userName });
        }
        public void setNhacNho(string userName, bool isOn)
        {
            if (isOn)
            {
                DataProvider.Instance.truyVanKTraVe("exec SetNN @i , @username", new object[] { 1, userName });
            }
            else DataProvider.Instance.truyVanKTraVe("exec SetNN @i , @username", new object[] { 0, userName });
        }
        public void setGhiNho(string userName, bool isOn)
        {
            if (isOn)
            {
                DataProvider.Instance.truyVanKTraVe("exec SetNNCV @i , @username", new object[] { 1, userName });
            }
            else DataProvider.Instance.truyVanKTraVe("exec SetNNCV @i , @username", new object[] { 0, userName });
        }

        public void setTimeNhacNho(string userName, int h, int m)
        {
            DataProvider.Instance.truyVanKTraVe("exec SetTimeNN @h , @m , @username", new object[] { h, m, userName });
        }
        #endregion

        public bool xoaTK(string password)
        {
            bool xoa = DataProvider.Instance.truyVanKTraVe("exec XoaTK @password ", new object[] {password});
            return xoa;
        }
        public bool DeleteAcc(string userName)
        {
            bool delete = DataProvider.Instance.truyVanKTraVe("exec DeleteAcc @userName ", new object[] {userName});
            return delete;
        }

        public bool changeUserName(string loginName,string userName)
        {
            bool change = DataProvider.Instance.truyVanKTraVe("exec changeUserName @loginName , @userName", new object[]{loginName, userName});
            return change;
        }

        public bool changePassWord(string loginName, string passWord)
        {
            bool change = DataProvider.Instance.truyVanKTraVe("exec changePassWord @loginName , @passWord ", new object[] {loginName, passWord });
            return change;
        }

        public static void khoiDong(bool i)
        {
            RegistryKey regkey = Registry.CurrentUser.CreateSubKey("Software\\JobsManagement");
            //mo registry khoi dong cung win
            RegistryKey regstart = Registry.CurrentUser.CreateSubKey("SOFTWARE\\Microsoft\\Windows\\CurrentVersion\\Run");
            
            if (i)
            {
                string keyvalue = "1";
                //string subkey = "Software\\ManhQuyen";
                //chen gia tri key
                regkey.SetValue("Index", keyvalue);
                //regstart.SetValue("taoregistrytronghethong", "E:\\Studing\\Bai Tap\\CSharp\\Channel 4\\bai temp\\tao registry trong he thong\\tao registry trong he thong\\bin\\Debug\\tao registry trong he thong.exe");
                regstart.SetValue("JobsManagement", Application.StartupPath + "\\JobsManagement.exe");
                ////dong tien trinh ghi key
                //regkey.Close();
            }
            else
            {
                try
                {
                    regstart.DeleteValue("JobsManagement");
                }
                catch { }
            }    
        }
        public static double getDCC(string loginName)
        {
            double DoChamChi = (double)DAO.DataProvider.Instance.truyVanCoMotKetQua("select dbo.DoChamChi( @username )", new object[] { loginName });
            DoChamChi = Math.Round(DoChamChi, 2);
            return DoChamChi;
        }
        public static void setDCC(TaiKhoan loginAcc)
        {
            loginAcc.DoChamChi = getDCC(loginAcc.TenDN);
        }
    }
}
