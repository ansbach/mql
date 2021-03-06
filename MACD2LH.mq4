//+------------------------------------------------------------------+
//|                                                      MACD2LH.mq4 |
//|                        Copyright 2020, MetaQuotes Software Corp. |
//|                                             https://www.mql5.com |
//+------------------------------------------------------------------+
#property copyright "Copyright 2020, MetaQuotes Software Corp."
#property link      "https://www.mql5.com"
#property version   "1.00"
#property strict

#property indicator_separate_window
#property indicator_buffers 3

#property indicator_color1 clrCrimson
#property indicator_type1 DRAW_LINE
#property indicator_width1 2

#property indicator_color2 clrCornflowerBlue
#property indicator_type2 DRAW_LINE
#property indicator_width2 2

#property indicator_color3 clrBlack
#property indicator_type3 DRAW_HISTOGRAM
#property indicator_width3 5

double _IndBuffer1[];
double _IndBuffer2[];
double _IndBuffer3[];

input int FirstEMA   = 12;  //ファーストEMA期間
input int SlowEMA    = 26;  //スローEMA期間
input int SignalLine = 9;   //シグナルライン期間

//+------------------------------------------------------------------+
//| Custom indicator initialization function                         |
//+------------------------------------------------------------------+

int OnInit()
  {
//--- indicator buffers mapping

   SetIndexBuffer(0,_IndBuffer1 );
   SetIndexBuffer(1,_IndBuffer2 );
   SetIndexBuffer(2,_IndBuffer3 );
//---
   return(INIT_SUCCEEDED);
  }
//+------------------------------------------------------------------+
//| Custom indicator iteration function                              |
//+------------------------------------------------------------------+
int OnCalculate(const int rates_total,
                const int prev_calculated,
                const datetime &time[],
                const double &open[],
                const double &high[],
                const double &low[],
                const double &close[],
                const long &tick_volume[],
                const long &volume[],
                const int &spread[])
  {
//---

   int end_index = Bars - prev_calculated;

   for(int icount =0; icount < end_index; icount++ )
   {
      double result1 = iMACD(NULL,0,FirstEMA,SlowEMA,SignalLine,PRICE_CLOSE,MODE_SIGNAL,icount);
      double result2 = iMACD(NULL,0,FirstEMA,SlowEMA,SignalLine,PRICE_CLOSE,MODE_MAIN  ,icount);
      double result3 = result2 - result1;
      
      _IndBuffer1[icount] = result1;
      _IndBuffer2[icount] = result2; 
      _IndBuffer3[icount] = result3; 
   }


//--- return value of prev_calculated for next call
   return(rates_total);
  }
//+------------------------------------------------------------------+
//| Timer function                                                   |
//+------------------------------------------------------------------+
void OnTimer()
  {
//---
   
  }
//+------------------------------------------------------------------+
//| ChartEvent function                                              |
//+------------------------------------------------------------------+
void OnChartEvent(const int id,
                  const long &lparam,
                  const double &dparam,
                  const string &sparam)
  {
//---
   
  }
//+------------------------------------------------------------------+
