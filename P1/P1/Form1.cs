using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace P1
{
    public partial class Form1 : Form
    {
        public Form1()
        {
            InitializeComponent();
        }
        public string deset;
        public string jedenact;
        public string dvanact;
        public string trinact;
        public string ctvrnact;
        public string patnact;
        public string x;
        public string y;
        private void button1_Click(object sender, EventArgs e)
        {
            textBox2.Clear();
            if(radioButton1.Checked)  // Ošetření binárního vstupu 
            {
                string bin = "a";
                char[] pole;
                bin = textBox1.Text;
                pole = bin.ToCharArray();
                if (pole.Contains('2') || pole.Contains('3') || pole.Contains('4') || pole.Contains('5') || pole.Contains('6') || pole.Contains('7') || pole.Contains('8') || pole.Contains('9'))
                {
                    MessageBox.Show("Zadáno špatné číslo, zadej číslo z binární soustavy");
                }
            }
            if(radioButton2.Checked) // Ošetření osmíčkového vstupu
            {
                string okt = "a";
                char[] pole;
                okt = textBox1.Text;
                pole = okt.ToCharArray();
                if (pole.Contains('8') || pole.Contains('9'))
                {
                    MessageBox.Show("Zadáno špatné číslo, zadej číslo z osmičkové soustavy");
                }
            }
            if (radioButton1.Checked && radioButton5.Checked || radioButton2.Checked && radioButton6.Checked || radioButton3.Checked && radioButton7.Checked || radioButton4.Checked && radioButton8.Checked)
            {
                string cislo = textBox1.ToString();
                textBox2.Text = textBox1.Text;
            }
            if (radioButton3.Checked && radioButton5.Checked) // převod z desítkové do binární
            {
                int a = int.Parse(textBox1.Text);
                List<int> list102 = new List<int>();
                while (a != 0)
                {
                    int b = a % 2;
                    a = a / 2;
                    list102.Add(b);
                }
                list102.Reverse();
                foreach (int n in list102)
                {
                    textBox2.Text = textBox2.Text + n;
                }
            }
            if (radioButton3.Checked && radioButton6.Checked) // převod z desítkové do osmičkové
            {
                int a = int.Parse(textBox1.Text);
                List<int> list108 = new List<int>();  // list z 10 do 8
                while (a != 0)
                {
                    int b = a % 8;
                    a = a / 8;
                    list108.Add(b);
                }
                list108.Reverse();
                foreach (int n in list108)
                {
                    textBox2.Text = textBox2.Text + n;
                }
            }
            if (radioButton1.Checked && radioButton7.Checked) // převod z binární do desítkové
            {
                string bin = "a";
                char[] pole;
                bin = textBox1.Text;
                pole = bin.ToCharArray();
                List<double> list210 = new List<double>(); // list z 2 do 10
                int mocnina = 0;
                for (int i = bin.Length - 1; i >= 0; i--)
                {
                    list210.Add(Convert.ToDouble(char.GetNumericValue(pole[i]) * Math.Pow(2, mocnina)));
                    mocnina = mocnina + 1;
                }
                long a = 0;
                for (int j = 0; j < bin.Length; j++)
                {
                    a = Convert.ToInt64(list210[j]) + a;
                    textBox2.Text = a.ToString();
                }
                mocnina = 0;
            }
            if (radioButton1.Checked && radioButton6.Checked) // převod z binární do osmičkové
            {
                string bin = "a";
                char[] pole;
                bin = textBox1.Text;
                pole = bin.ToCharArray();
                List<double> list210 = new List<double>();
                int mocnina = 0;
                for (int i = bin.Length - 1; i >= 0; i--)
                {
                    list210.Add(Convert.ToDouble(char.GetNumericValue(pole[i]) * Math.Pow(2, mocnina)));
                    mocnina = mocnina + 1;
                }
                long a = 0;
                for (int j = 0; j < bin.Length; j++)
                {
                    a = Convert.ToInt64(list210[j]) + a;
                }
                List<long> list108 = new List<long>();
                while (a != 0)
                {
                    long b = a % 8;
                    a = a / 8;
                    list108.Add(b);
                }
                list108.Reverse();
                foreach (int n in list108)
                {
                    textBox2.Text = textBox2.Text + n;
                }
            }
            if (radioButton2.Checked && radioButton5.Checked) // převod z osmičkové do binární
            {
                string okt = "a";
                char[] pole;
                okt = textBox1.Text;
                pole = okt.ToCharArray();
                List<double> list810 = new List<double>();
                int mocnina = 0;
                for (int i = okt.Length - 1; i >= 0; i--)
                {
                    list810.Add(Convert.ToDouble(char.GetNumericValue(pole[i]) * Math.Pow(8, mocnina)));
                    mocnina = mocnina + 1;
                }
                long a = 0;
                for (int j = 0; j < okt.Length; j++)
                {
                    a = Convert.ToInt64(list810[j]) + a;
                }
                List<double> list102 = new List<double>();
                while (a != 0)
                {
                    long b = a % 2;
                    a = a / 2;
                    list102.Add(b);
                }
                list102.Reverse();
                foreach (int n in list102)
                {
                    textBox2.Text = textBox2.Text + n;
                }
            }
            if (radioButton2.Checked && radioButton7.Checked) // převod z osmičkové do desítkové
            {
                string okt = "a";
                char[] pole;
                okt = textBox1.Text;
                pole = okt.ToCharArray();
                List<double> list810 = new List<double>();
                int mocnina = 0;
                for (int i = okt.Length - 1; i >= 0; i--)
                {
                    list810.Add(Convert.ToDouble(char.GetNumericValue(pole[i]) * Math.Pow(8, mocnina)));
                    mocnina = mocnina + 1;
                }
                for (int j = 0; j < okt.Length; j++)
                {
                    long a = 0;
                    a = Convert.ToInt64(list810[j]) + a;
                    textBox2.Text = a.ToString();
                }
            }
            if (radioButton3.Checked && radioButton8.Checked) // převod z desítkové do šestnácktkové
            {
                int a = int.Parse(textBox1.Text);
                List<string> list1016 = new List<string>();
                while (a != 0)
                {
                    int b = a % 16;
                    a = a / 16;
                    if (b < 10)
                    {
                        list1016.Add(b.ToString());
                    }
                    if (b == 10)
                    {
                        deset = b.ToString();
                        deset = "A";
                        list1016.Add(deset);
                    }
                    if (b == 11)
                    {
                        jedenact = b.ToString();
                        jedenact = "B";
                        list1016.Add(jedenact);
                    }
                    if (b == 12)
                    {
                        dvanact = b.ToString();
                        dvanact = "C";
                        list1016.Add(dvanact);
                    }
                    if (b == 13)
                    {
                        trinact = b.ToString();
                        trinact = "D";
                        list1016.Add(trinact);
                    }
                    if (b == 14)
                    {
                        ctvrnact = b.ToString();
                        ctvrnact = "E";
                        list1016.Add(ctvrnact);
                    }
                    if (b == 15)
                    {
                        patnact = b.ToString();
                        patnact = "F";
                        list1016.Add(patnact);
                    }
                }
                list1016.Reverse();
                foreach (string n in list1016)
                {
                    textBox2.Text = textBox2.Text + n;
                }
            }
            if (radioButton1.Checked && radioButton8.Checked) // z binární do šestnáctkové
            {
                string bin = "a";
                char[] pole;
                bin = textBox1.Text;
                pole = bin.ToCharArray();
                List<double> lista = new List<double>();
                int mocnina = 0;
                for (int i = bin.Length - 1; i >= 0; i--)
                {
                    lista.Add(Convert.ToDouble(char.GetNumericValue(pole[i]) * Math.Pow(2, mocnina)));
                    mocnina = mocnina + 1;
                }
                long a = 0;
                for (int j = 0; j < bin.Length; j++)
                {
                    a = Convert.ToInt64(lista[j]) + a;
                }
                List<string> list216 = new List<string>();
                long b = 0;
                while (a != 0)
                {
                    b = a % 16;
                    a = a / 16;
                    if (b < 10)
                    {
                        list216.Add(b.ToString());
                    }
                    if (b == 10)
                    {
                        deset = b.ToString();
                        deset = "A";
                        list216.Add(deset);
                    }
                    if (b == 11)
                    {
                        jedenact = b.ToString();
                        jedenact = "B";
                        list216.Add(jedenact);
                    }
                    if (b == 12)
                    {
                        dvanact = b.ToString();
                        dvanact = "C";
                        list216.Add(dvanact);
                    }
                    if (b == 13)
                    {
                        trinact = b.ToString();
                        trinact = "D";
                        list216.Add(trinact);
                    }
                    if (b == 14)
                    {
                        ctvrnact = b.ToString();
                        ctvrnact = "E";
                        list216.Add(ctvrnact);
                    }
                    if (b == 15)
                    {
                        patnact = b.ToString();
                        patnact = "F";
                        list216.Add(patnact);
                    }
                }
                mocnina = 0;
                list216.Reverse();
                foreach (string n in list216)
                {
                    textBox2.Text = textBox2.Text + n;
                }
            }
            if (radioButton2.Checked && radioButton8.Checked) // z osmičkové do šestnáctkové
            {
                string okt = "a";
                char[] pole;
                okt = textBox1.Text;
                pole = okt.ToCharArray();
                List<double> list816 = new List<double>(); //list z8do16
                int mocnina = 0;
                for (int i = okt.Length - 1; i >= 0; i--)
                {
                    list816.Add(Convert.ToDouble(char.GetNumericValue(pole[i]) * Math.Pow(8, mocnina)));
                    mocnina = mocnina + 1;
                }
                long a = 0;
                for (int j = 0; j < okt.Length; j++)
                {
                    a = Convert.ToInt64(list816[j]) + a;
                }
                List<string> list8162 = new List<string>(); //list z8do16č2
                while (a != 0)
                {
                    long b = a % 16;
                    a = a / 16;
                    if (b < 10)
                    {
                        list8162.Add(b.ToString());
                    }
                    if (b == 10)
                    {
                        deset = b.ToString();
                        deset = "A";
                        list8162.Add(deset);
                    }
                    if (b == 11)
                    {
                        jedenact = b.ToString();
                        jedenact = "B";
                        list8162.Add(jedenact);
                    }
                    if (b == 12)
                    {
                        dvanact = b.ToString();
                        dvanact = "C";
                        list8162.Add(dvanact);
                    }
                    if (b == 13)
                    {
                        trinact = b.ToString();
                        trinact = "D";
                        list8162.Add(trinact);
                    }
                    if (b == 14)
                    {
                        ctvrnact = b.ToString();
                        ctvrnact = "E";
                        list8162.Add(ctvrnact);
                    }
                    if (b == 15)
                    {
                        patnact = b.ToString();
                        patnact = "F";
                        list8162.Add(patnact);
                    }
                }
                mocnina = 0;
                list8162.Reverse();
                foreach (string n in list8162)
                {
                    textBox2.Text = textBox2.Text + n;
                }
            }
            if (radioButton4.Checked && radioButton5.Checked) // z šestnáctkové do binární
            {
                char[] pole1 = { '0', '1', '2', '3', '4', '5', '6', '7', '8', '9', 'A', 'B', 'C', 'D', 'E', 'F' };
                string hex = "a";
                char[] pole;
                hex = textBox1.Text;
                pole = hex.ToCharArray();
                List<double> list162 = new List<double>(); // list z 16 do 2
                int mocnina = 0;
                Array.Reverse(pole);
                char p;
                int index;
                double a = 0;
                for (int i = 0; i < pole.Length; i++)
                {
                    p = pole[i];
                    index = Array.IndexOf(pole1, p);
                    a = index * Math.Pow(16, mocnina);
                    list162.Add(a);
                    mocnina = mocnina + 1;
                }
                long b = 0;
                for (int j = 0; j < hex.Length; j++)
                {
                    b = Convert.ToInt64(list162[j]) + b;
                }
                List<long> list1622 = new List<long>(); // list z 16 do 2 číslo 2
                long c = 0;
                while (b != 0)
                {
                    c = b % 2;
                    b = b / 2;
                    list1622.Add(c);
                }
                list1622.Reverse();
                foreach (int n in list1622)
                {
                    textBox2.Text = textBox2.Text + n.ToString();
                }
                mocnina = 0;
            }
            if (radioButton4.Checked && radioButton7.Checked) // z šestnáctkové do desítkové
            {
                char[] pole1 = { '0', '1', '2', '3', '4', '5', '6', '7', '8', '9', 'A', 'B', 'C', 'D', 'E', 'F' };
                string hex = "a";
                char[] pole;
                hex = textBox1.Text;
                pole = hex.ToCharArray();
                List<double> list1610 = new List<double>();
                int mocnina = 0;
                Array.Reverse(pole);
                char p;
                int index = 0;
                double a = 0;
                for (int i = 0; i < pole.Length; i++)
                {
                    p = pole[i];
                    index = Array.IndexOf(pole1, p);
                    a = index * Math.Pow(16, mocnina);
                    list1610.Add(a);
                    mocnina = mocnina + 1;
                }
                long b = 0;
                for (int j = 0; j < hex.Length; j++)
                {
                    b = Convert.ToInt64(list1610[j]) + b;
                    textBox2.Text = b.ToString();
                }
                mocnina = 0;
            }
            if(radioButton4.Checked && radioButton6.Checked) // z šestnáctkové do osmičkové
            {
                char[] pole1 = { '0', '1', '2', '3', '4', '5', '6', '7', '8', '9', 'A', 'B', 'C', 'D', 'E', 'F' };
                string hex = "a";
                char[] pole;
                hex = textBox1.Text;
                pole = hex.ToCharArray();
                List<double> list168 = new List<double>(); // list z 16 do 8
                int mocnina = 0;
                Array.Reverse(pole);
                char p;
                int index;
                double a = 0;
                for (int i = 0; i < pole.Length; i++)
                {
                    p = pole[i];
                    index = Array.IndexOf(pole1, p);
                    a = index * Math.Pow(16, mocnina);
                    list168.Add(a);
                    mocnina = mocnina + 1;
                }
                long b = 0;
                for (int j = 0; j < hex.Length; j++)
                {
                    b = Convert.ToInt64(list168[j]) + b;
                }
                long c = 0;
                List<long> list1682 = new List<long>();  // list z 16 do 8 číslo 2
                while (b != 0)
                {
                    c = b % 8;
                    b = b / 8;
                    list1682.Add(c);
                }
                list1682.Reverse();
                foreach (int n in list1682)
                {
                    textBox2.Text = textBox2.Text + n.ToString();
                }
                mocnina = 0;
            }
        }
        private void radioButton1_CheckedChanged(object sender, EventArgs e)
        {
         
        }

        private void textBox1_TextChanged(object sender, EventArgs e)
        {

        }

        private void button2_Click(object sender, EventArgs e)
        {
            Close();
        }

        private void radioButton2_CheckedChanged(object sender, EventArgs e)
        {

        }

        private void radioButton3_CheckedChanged(object sender, EventArgs e)
        {

        }

        private void radioButton4_CheckedChanged(object sender, EventArgs e)
        {

        }

        private void radioButton5_CheckedChanged(object sender, EventArgs e)
        {

        }

        private void radioButton6_CheckedChanged(object sender, EventArgs e)
        {

        }

        private void radioButton7_CheckedChanged(object sender, EventArgs e)
        {

        }

        private void radioButton8_CheckedChanged(object sender, EventArgs e)
        {

        }
    }
}
