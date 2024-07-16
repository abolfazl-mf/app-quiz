class  Questions{
   String questions;
   String answer1;
   String answer2;
   int trueAnswer;
   String imageAddress;
   Questions(this.questions,this.answer1,this.answer2,this.trueAnswer,this.imageAddress);

   bool isRight(int num){
     if(num==1||num==2){
       if(trueAnswer==1){
         if(num==1){
           return true;
         }
         else{
           return false;
         }
       }
       else{
         if(num==2){
           return true;
         }
         else{
           return false;
         }
       }
     }
     else{
       print('error in handle');
       return false;
     }
   }

}
List<Questions> questionsList=[
    Questions('ایا موبایل روششنه؟', 'بله', 'خیر', 1, 'asset/images/mobile.jpg'),
    Questions('رکورد دارترین تیم ucl', 'رئال', 'منیونایتد', 1, 'asset/images/ucl.jpg'),
    Questions('بیشترین قهرمانی لیگ ایران؟', 'پرسپولیس', 'استقلال', 1, 'asset/images/iran.jpg'),
    Questions('بزرگترین اقیانوس جهان؟', 'ارام', 'اطلس', 2, 'asset/images/ogh.jpg'),
    Questions('عمیق ترین رود جهان؟', 'امازون', 'میسیسیپی', 1, 'asset/images/river.jpg'),
    Questions('کوه پیر واقع در امریکای شمالی؟', 'برزیل', 'تاینا', 2, 'asset/images/mountain.jpg'),
    Questions('قوی ترین مرد جهان؟', ' فورد', 'شالاسف', 2, 'asset/images/strong.jpg'),
    Questions('قران چند سال بر پیامبر فرستاده شد؟', 'بیست وپنچ ', 'بیست وسه ', 1, 'asset/images/quran.jpeg'),
    Questions('سریع ترین حیوان جهان؟', 'فیل', 'یوزپلنگ', 1, 'asset/images/animal.jpg'),
];