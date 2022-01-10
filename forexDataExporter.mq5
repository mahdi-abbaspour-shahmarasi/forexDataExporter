//+------------------------------------------------------------------+
//|                                               fxDataExporter.mq5 |
//|                                  Copyright 2022, MetaQuotes Ltd. |
//|                                       https://www.m-abbaspour.ir |
//|                                              http://www.topon.ir |
//+------------------------------------------------------------------+
#property copyright "Copyright 2022, MetaQuotes Ltd."
#property link      "http://www.topon.ir/"
#property version   "1.10"

//+------------------------------------------------------------------+
//| Indicators Settings                                   |
//+------------------------------------------------------------------+

input group    "__ RSI Settings __";
input int ma_period = 14;
input ENUM_APPLIED_PRICE applied_price_rsi = PRICE_CLOSE;
//___________________________________________________________________
input group    "__ 1st_MA Settings __";
input int ma_period_1st = 9;
input int ma_shift_1st = 1;
input ENUM_MA_METHOD ma_method_1st = MODE_EMA;
input ENUM_APPLIED_PRICE applied_price_1st = PRICE_TYPICAL;
//___________________________________________________________________  
input group    "__ 2nd_MA Settings __";
input int ma_period_2nd = 26;
input int ma_shift_2nd = 1;
input ENUM_MA_METHOD ma_method_2nd = MODE_EMA;
input ENUM_APPLIED_PRICE applied_price_2nd = PRICE_TYPICAL;
//___________________________________________________________________
input group    "__ 3rd_MA Settings __";
input int ma_period_3rd = 52;
input int ma_shift_3rd = 1;
input ENUM_MA_METHOD ma_method_3rd = MODE_EMA;
input ENUM_APPLIED_PRICE applied_price_3rd = PRICE_TYPICAL;
//___________________________________________________________________
input group    "__ 4th_MA Settings __";
input int ma_period_4th = 104;
input int ma_shift_4th = 1;
input ENUM_MA_METHOD ma_method_4th = MODE_EMA;
input ENUM_APPLIED_PRICE applied_price_4th = PRICE_TYPICAL;
//___________________________________________________________________
input group    "__ 5th_MA Settings __";
input int ma_period_5th = 200;
input int ma_shift_5th = 1;
input ENUM_MA_METHOD ma_method_5th = MODE_EMA;
input ENUM_APPLIED_PRICE applied_price_5th = PRICE_TYPICAL;  

//+------------------------------------------------------------------+
//| Expert initialization function                                   |
//+------------------------------------------------------------------+
int currentCandleNo=0;
int OnInit()
 { 
   currentCandleNo=iBars(Symbol(),PERIOD_CURRENT); 
   int f=FileOpen(Symbol()+"_"+EnumToString(Period())+".csv",FILE_READ|FILE_WRITE|FILE_TXT);
      FileSeek(f,0,SEEK_END);
      FileWrite(f,"DateTime,Open,High,Low,Close,Ma"+string(ma_period_1st)+",MA"+string(ma_period_2nd)+",MA"+string(ma_period_3rd)+",MA"+string(ma_period_4th)+",MA"+string(ma_period_5th)+",RSI"); 
      FileFlush(f);    
      FileClose(f);
   return(INIT_SUCCEEDED);
  }
//+------------------------------------------------------------------+
//| Expert tick function                                             |
//+------------------------------------------------------------------+
void OnTick()
  {  
  int number=iBars(Symbol(),PERIOD_CURRENT);
  if(number!=currentCandleNo)
    {
      datetime dt= iTime(Symbol(),PERIOD_CURRENT,1);
      double  open = iOpen(Symbol(),PERIOD_CURRENT,1);
      double close = iClose(Symbol(),PERIOD_CURRENT,1);
      double  high = iHigh(Symbol(),PERIOD_CURRENT,1);
      double   low = iLow(Symbol(),PERIOD_CURRENT,1);
      
      double ma_1st=iMA(Symbol(), PERIOD_CURRENT,ma_period_1st,ma_shift_1st,ma_method_1st,applied_price_1st);
      double movingAverageValues_1st[]; 
      ArraySetAsSeries (movingAverageValues_1st, true);
      CopyBuffer(ma_1st,0, 0, 100, movingAverageValues_1st);
      
      double ma_2nd=iMA(Symbol(), PERIOD_CURRENT,ma_period_2nd,ma_shift_2nd,ma_method_2nd,applied_price_2nd);
      double movingAverageValues_2nd[]; 
      ArraySetAsSeries (movingAverageValues_2nd, true);
      CopyBuffer(ma_2nd,0, 0, 100, movingAverageValues_2nd);
      
      double ma_3rd=iMA(Symbol(), PERIOD_CURRENT,ma_period_3rd,ma_shift_3rd,ma_method_3rd,applied_price_3rd);
      double movingAverageValues_3rd[]; 
      ArraySetAsSeries (movingAverageValues_3rd, true);
      CopyBuffer(ma_3rd,0, 0, 100, movingAverageValues_3rd);
      
      double ma_4th=iMA(Symbol(), PERIOD_CURRENT,ma_period_4th,ma_shift_4th,ma_method_4th,applied_price_4th);
      double movingAverageValues_4th[]; 
      ArraySetAsSeries (movingAverageValues_4th, true);
      CopyBuffer(ma_4th,0, 0, 100, movingAverageValues_4th);
      
      double ma_5th=iMA(Symbol(), PERIOD_CURRENT,ma_period_5th,ma_shift_5th,ma_method_5th,applied_price_5th);
      double movingAverageValues_5th[]; 
      ArraySetAsSeries (movingAverageValues_5th, true);
      CopyBuffer(ma_5th,0, 0, 100, movingAverageValues_5th);
      
      double rsi=iRSI (Symbol(),PERIOD_CURRENT,ma_period,applied_price_rsi);
      double rsiArray[];
      ArraySetAsSeries(rsiArray, true);
      CopyBuffer(rsi,0,0,100,rsiArray);
      
      int h=FileOpen(Symbol()+"_"+EnumToString(Period())+".csv",FILE_READ|FILE_WRITE|FILE_TXT);
      
      if(h==INVALID_HANDLE)
       {
         Alert("Error opening file");
         return;
       }
       FileSeek(h,0,SEEK_END);
       FileWrite(h,string(dt)+","+DoubleToString(open)+","
                                 +DoubleToString(high)+","
                                 +DoubleToString(low)+","
                                 +DoubleToString(close)+","
                                 +DoubleToString(movingAverageValues_1st[0])+","
                                 +DoubleToString(movingAverageValues_2nd[0])+","
                                 +DoubleToString(movingAverageValues_3rd[0])+","
                                 +DoubleToString(movingAverageValues_4th[0])+","
                                 +DoubleToString(movingAverageValues_5th[0])+","
                                 +DoubleToString(rsiArray[0])); 
       FileFlush(h);    
       FileClose(h);
       currentCandleNo=number;
    }
  Comment("Number Of Candle:"+string(number));   
  }
//+------------------------------------------------------------------+
