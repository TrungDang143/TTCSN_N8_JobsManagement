﻿using JobsManagement.DTO;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;
using System.Windows.Input;
using static System.Windows.Forms.VisualStyles.VisualStyleElement.StartPanel;

namespace JobsManagement.DAO
{
    internal class CongViecDAO
    {
        public static bool addJob(CongViec cv)
        {
            int id = cv.Id;
            string nd = cv.NoiDung;
            DateTime tgBD = cv.TgBD;
            DateTime tgKT = cv.TgKT;
            string trangThai = cv.TrangThai;
            int t2;
            int t3;
            int t4;
            int t5;
            int t6;
            int t7;
            int cn;

            if (cv.LapLai[0] == true)
            {
                t2 = 0;
                t3 = 0;
                t4 = 0;
                cn = 0;
                t5 = 0;
                t6 = 0;
                t7 = 0;
            }
            else if (cv.LapLai[1] == true)
            {
                t2 = 1;
                t3 = 1;
                t4 = 1;
                cn = 1;
                t5 = 1;
                t6 = 1;
                t7 = 1;
            }
            else
            {
                t2 = cv.LapLai[2] == true ? 1 : 0;
                t3 = cv.LapLai[3] == true ? 1 : 0;
                t4 = cv.LapLai[4] == true ? 1 : 0;
                t5 = cv.LapLai[5] == true ? 1 : 0;
                t6 = cv.LapLai[6] == true ? 1 : 0;
                t7 = cv.LapLai[7] == true ? 1 : 0;
                cn = cv.LapLai[8] == true ? 1 : 0;
            }

            bool kq = DAO.DataProvider.Instance.truyVanKTraVe("exec AddJob @id, @noiDungCV, @tgBD, @tgKT, @trangThai, @t2, @t3, @t4, @t5, @t6, @t7, @cn, @tenDangNhap",new object[] { id, nd, tgBD, tgKT, trangThai, t2, t3, t4, t5, t6, t7, cn, cv.TenDN });
            return kq;
        }
        public static int nextID(string userName)
        {
            return (int)DAO.DataProvider.Instance.truyVanCoMotKetQua("print dbo.getNextID(@username)", new object[] { userName });
        }


        public static int tongCV(string userName)
        {
            int kq = (int)DAO.DataProvider.Instance.truyVanCoMotKetQua("exec GetSoCV @username", new object[] { userName });
            return kq;
        }
        public static int CVdangDienRa(string userName)
        {
            int kq = (int)DAO.DataProvider.Instance.truyVanCoMotKetQua("exec GetCoSVbyTT @tt @username", new object[] { "Đang diễn ra", userName });
            return kq;
        }

    }
}
