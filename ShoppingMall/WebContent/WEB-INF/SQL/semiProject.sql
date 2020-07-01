show user;
-- USER이(가) "SEMIORAUSER1"입니다.

select * FROM tab;

drop table review_table;
drop table order_product_table;
drop table one_inquiry_table;
drop table one_category_table;
drop table order_table;
drop table order_state_table;
drop table product_inquiry_table;
drop table product_detail_table;
drop table product_table;
drop table product_category_table;
drop table product_subcategory_table;
drop table notice_table;
drop table FAQ_table;
drop table inquiry_category_table;
drop table member_table;
drop table basket_table;

-- 회원 테이블 --
create table member_table
(member_num number  not null -- 회원번호 필수입력 + 유일한 값(primary) + 시퀀스 사용
,name       varchar2(30) not null -- 성명 필수입력
,userid     varchar2(50) not null -- 유저id 필수입력 + 유일한 값
,pwd        varchar2(300) not null -- 암호 필수입력 (SHA-256 암호화 대상)
,email      varchar2(300) not null -- 이메일(암호화) 필수입력 + 유일한 값
,mobile       varchar2(30) not null -- 핸드폰 번호 (암호화)
,postcode   varchar2(100) -- 우편번호
,address    varchar2(200) -- 주소
,detailAddress  varchar2(100) -- 상세주소
,gender     number(1) -- 성별
,birthday   varchar2(8) -- 생년월일
,registerdate date default sysdate -- 가입날짜
,pwd_change_date date default sysdate -- 암호 수정한 날짜 
,last_login_date date default sysdate -- 마지막 로그인 날짜
,status     number(1) default 1 -- 회원상태(일반회원, 관리자, 휴면상태)
,constraint pk_member_table PRIMARY KEY (member_num)
,constraint uq_member_table_userid UNIQUE(userid)
,constraint uq_member_table_email unique(email)
,constraint ck_member_table_gender CHECK (gender in (0,1,2))
,constraint ck_member_table_status CHECK (status in(0,1,2))
);

select*
from member_table;

update member_table set pwd='9695b88a59a1610320897fa84cb7e144cc51f2984520efb77111d94b402a8382'
where userid='hyeminj98';

commit;

-- 회원테이블에 사용할 시퀀스 생성 --
create sequence seq_member_table
start with 1
increment by 1
nomaxvalue
nominvalue
nocycle
nocache;


-- 상품 대분류 카테고리 테이블 생성 --
create table product_category_table
( category_num  number            -- 대분류 카테고리 번호 필수+고유
, category_content  varchar2(50)  -- 번호에 해당하는 실제 표시할 내용
,constraint pk_category_num primary key (category_num)
);

select*
from product_category_table;

insert into product_category_table(category_num, category_content) values(1,'채소');
insert into product_category_table(category_num, category_content) values(2,'과일 견과');
insert into product_category_table(category_num, category_content) values(3,'수산 해산');
insert into product_category_table(category_num, category_content) values(4,'정육 계란');
insert into product_category_table(category_num, category_content) values(5,'음료 우유');
commit;

-- 상품 소분류 카테고리 테이블 생성 --
create table product_subcategory_table
(subcategory_num    number  -- 소분류 카테고리 번호 필수+고유
,subcategory_content varchar2(50) -- 번호에 해당하는 실제 표시할 내용
,constraint pk_product_subcategory_table primary key (subcategory_num)
);


insert into product_subcategory_table(subcategory_num, subcategory_content) values(11,'기본채소');
insert into product_subcategory_table(subcategory_num, subcategory_content) values(12,'쌈 샐러드');
insert into product_subcategory_table(subcategory_num, subcategory_content) values(13,'특수채소');
insert into product_subcategory_table(subcategory_num, subcategory_content) values(21,'국산과일');
insert into product_subcategory_table(subcategory_num, subcategory_content) values(22,'수입과일');
insert into product_subcategory_table(subcategory_num, subcategory_content) values(23,'냉동 건과일');
insert into product_subcategory_table(subcategory_num, subcategory_content) values(31,'생선류');
insert into product_subcategory_table(subcategory_num, subcategory_content) values(32,'오징어 낙지 문어');
insert into product_subcategory_table(subcategory_num, subcategory_content) values(33,'새우 게 랍스타');
insert into product_subcategory_table(subcategory_num, subcategory_content) values(41,'소고기');
insert into product_subcategory_table(subcategory_num, subcategory_content) values(42,'돼지고기');
insert into product_subcategory_table(subcategory_num, subcategory_content) values(43,'닭 오리고기');
insert into product_subcategory_table(subcategory_num, subcategory_content) values(51,'생수 음료 주스');
insert into product_subcategory_table(subcategory_num, subcategory_content) values(52,'커피 차');
insert into product_subcategory_table(subcategory_num, subcategory_content) values(53,'우유 두유 요거트');
commit;

select * from product_category_table;
select * from product_subcategory_table;



-- 상품 테이블 생성 --
create table product_table
(product_num    number not null -- 상품번호 필수+고유 시퀀스 사용
,product_name   varchar2(200) not null -- 상품이름 필수+고유
,price          number  not null -- 가격 필수
,stock          number not null -- 재고 필수
,origin         varchar2(100) -- 원산지
,packing      varchar2(80) -- 포장방법
,unit           varchar2(50) -- 단위
,registerdate   date default sysdate -- 등록날짜
,sale           number default 0 -- 세일 %값
,best_point     number default 0 -- 관리자가 추천하는 수 (MD추천)
,seller         varchar2(50) -- 판매자(관리자 모드시에 사용)
,seller_phone   varchar2(80) -- 판매자 번호(관리자 모드시에 사용)
,explain    varchar2(4000) -- 상품설명
,representative_img varchar2(200) not null
,fk_category_num    number not null -- product_category_table에 있는 category_num을 참조하는 컬럼
,fk_subcategory_num number not null -- product_subcategory_table에 있는 subcategory_num을 참조하는 컬럼
,constraint pk_product_table primary key (product_num)
,constraint uq_product_product_name   unique (product_name)
,constraint fk_product_category_num FOREIGN key(fk_category_num) REFERENCES product_category_table(category_num)
,constraint fk_product_subcategory_num FOREIGN key(fk_subcategory_num) REFERENCES product_subcategory_table(subcategory_num)
);


-- 상품 테이블에 사용할 시퀀스 생성 --
create sequence seq_product_table
start with 1
increment by 1
nomaxvalue
nominvalue
nocycle
nocache;

select seq_product_table.nextval AS PNUM
from dual;

update product_table set explain = 
'몸통과 다리가 온전히 붙어 있는 통문어는 참 쓸 곳이 많아요.한 냄비 가득 푸짐하게 자려내는 해물찜이나 큼직한 튀김의 메인 재료는 물론 제수용으로도 알맞지요'
where product_num=151;
commit;
-- 상품 이미지와 설명 테이블 생성 --

create table product_image_table
(fk_product_num number not null -- 상품테이블에 있는 상품번호를 참조받는 컬럼
,image  varchar2(200)
,constraint fk_prodcut_detail_num FOREIGN key (fk_product_num) REFERENCES product_table(product_num) on DELETE CASCADE
);

select*
from product_table where product_name like '%'||'오징어'||'%';


-- 상품문의 테이블 생성 --
create table product_inquiry_table
(inquiry_num    number not null     -- 상품문의 번호 필수+고유 시퀀스 사용
,subject    varchar2(100) not null   -- 제목 필수
,content    varchar2(4000) not null -- 내용 필수
,write_date date default sysdate    -- 작성날짜 
,answer     varchar2(4000)          -- 관리자의 답변(문의가 들어오면 바로 답변을 받는 것이 아니기에 null허용)
,fk_member_num  number not null     -- 회원테이블의 회원번호를 참조받는 컬럼 필수(참조하는 값이 삭제되면 따라서 삭제됨)
,fk_product_num number not null     -- 상품테이블의 회원번호를 참조받는 컬럼 필수(참조하는 값이 삭제되면 따라서 삭제됨)
,emailFlag      number(1) default 0 -- 이메일로 답변 받고자 하는지 판단하는 컬럼
,smsFlag        number(1) default 0 -- 문자로 답변 받고자 하는지 판단하는 컬럼
,secretFlag     number(1) default 0 -- 비밀글로 하고자 하는지 판단하는 컬럼
,constraint pk_product_inquiry primary key(inquiry_num)
,constraint fk_inquiry_member FOREIGN key(fk_member_num) REFERENCES member_table(member_num)on delete CASCADE
,constraint fk_inquiry_product foreign key(fk_product_num) REFERENCES product_table(product_num)on delete cascade
,constraint ck_emailFlag check (emailFlag in(0,1))
,constraint ck_smsFlag check (smsFlag in(0,1))
,constraint ck_secretFlag check (secretFlag in(0,1))
);

-- 상품문의 이미지 테이블 --
create table product_inquiry_image_table
(fk_inquiry_num number not null
,image varchar2(100)
,constraint fk_inquiry_image FOREIGN key (fk_inquiry_num) REFERENCES product_inquiry_table(inquiry_num) on delete CASCADE
);

select * from product_inquiry_image_table;

select * from product_inquiry_table;

update product_inquiry_table set answer = '답변입니다.' where inquiry_num=9;

commit;

select count(*) from 
    (select T.RON, answer, inquiry_num, subject, content from
        (select rownum as RON, answer, inquiry_num, subject, content from product_inquiry_table)T 
    where T.RON between 1 and 0)N 
where N.answer is null;

SELECT LAST_NUMBER 
FROM  USER_SEQUENCES WHERE  SEQUENCE_NAME = 'SEQ_PRODUCT_INQUIRY';

-- 상품문의 테이블에 사용할 시퀀스 생성 --
create sequence seq_product_inquiry
start with 1
increment by 1
nomaxvalue
nominvalue
nocycle
nocache;


-- 배송상테 테이블 생성 --
create table order_state_table
(category_num   number  not null -- 배송상태 카테고리 번호 (1:상품준비중, 2:배송중, 3:배송완료)
,order_state    varchar2(50) -- 번호에 해당하는 실제 내용
,constraint pk_order_state  primary key(category_num)
);

select * FROM order_state_table;

insert into order_state_table(category_num, order_state) values(1, '상품준비중');
insert into order_state_table(category_num, order_state) values(2, '배송중');
insert into order_state_table(category_num, order_state) values(3, '배송완료');

commit;

-- 주문내역 상품 상세보기(혜민) 
select P.representative_img, P.product_name, OP.price, OP.product_count,
	OS.order_state, OP.reviewFlag
from product_table P join order_product_table OP
on P.product_num = OP.fk_product_num
join order_table O
on OP.fk_order_num = O.order_num
join order_state_table OS
on O.fk_category_num = OS.category_num
where OP.fk_order_num = 1;


-- 작성가능 후기(혜민)
select count(*)
from(
select OP.fk_order_num, P.representative_img, P.product_name, OP.product_count
from order_table O join order_product_table OP 
on O.order_num = OP.fk_order_num
join product_table P
on OP.fk_product_num = P.product_num
where O.fk_member_num = 1 and OP.reviewFlag = 0 and O.fk_category_num = 3);


-- 주문 정보 테이블 생성 --
create table order_table
(order_num  number  not null    -- 주문번호 필수+고유 시퀀스 사용
,order_date date default sysdate    -- 주문날짜
,recipient  varchar2(50) not null   -- 받는 사람 필수
,recipient_mobile   varchar2(100) not null  -- 받는 사람의 연락처 필수
,recipient_postcode varchar2(100) not null  -- 받는 사람의 우편번호
,recipient_address  varchar2(200) not null  -- 받는 사람의 주소
,recipient_detailaddress varchar2(200) not null -- 받는 사람의 상세주소
,price  number  not null    -- 주문금액 필수
,memo   varchar2(200)       -- 요청사항
,fk_member_num  number  not null    -- 회원테이블의 회원번호를 참조하는 컬럼
,fk_category_num number not null    -- 주문상태 케이블의 주문상태 번호를 참조하는 컬럼
,constraint pk_order_table  primary key(order_num)
,constraint fk_order_member FOREIGN key(fk_member_num) REFERENCES member_table(member_num)
,constraint fk_order_category foreign key(fk_category_num) references order_state_table(category_num)
);
select * from order_table;
select * from order_product_table;
select * from basket_table;

update order_table set fk_category_num = 3
where order_num = 1;

update order_table set fk_category_num = 3
where order_num = 2;

commit;

-- 주문 테이블에 사용할 시퀀스 생성 --
create sequence seq_order_table
start with 1
increment by 1
nomaxvalue
nominvalue
nocycle
nocache;


-- 주문상품 테이블 생성 --
create table order_product_table
(product_count  number not null -- 주문한 상품의 갯수 필수
,fk_order_num   number not null -- 주문정보 테이블의 주문번호를 참조하는 컬럼
,fk_product_num number not null -- 상품테이블의 상품번호를 참조하는 컬럼
,price          number not null -- 주문상품의 가격
,reviewFlag     number(1) default 0
,constraint fk_order FOREIGN key (fk_order_num) REFERENCES order_table(order_num)
,constraint fk_product FOREIGN key (fk_product_num ) REFERENCES product_table(product_num)
,constraint ck_reviewFlag check (reviewFlag in (0,1))
);
select * from order_table O join order_product_table OP on O.order_num = OP.fk_order_num;

-- 고객 후기 테이블 --
create table review_table
(review_num number not null -- 후기 번호 필수+고유 시퀀스 사용
,subject    varchar2(100) not null -- 후기 제목  필수
,content    varchar2(4000) not null -- 후기 내용 필수
,write_date date default sysdate -- 작성 날짜
,hit        number default 0 -- 조회수
,favorite   number default 0 -- 좋아요 수
,fk_product_num number not null -- 상품테이블에서 상품번호를 참조하는 컬럼 -- 두 개의 컬럼을 복합해서 유니크 키로 제약 
,fk_order_num   number not null -- 주문테이블에서 주문번호를 참조하는 컬럼 --
,fk_member_num  number not null -- 회원테이블에서 회원번호를 참조하는 컬림
,constraint pk_review_table primary key (review_num)
,constraint fk_review_order FOREIGN key (fk_order_num) REFERENCES order_table(order_num)
,constraint fk_review_product FOREIGN key (fk_product_num) REFERENCES product_table(product_num) on delete CASCADE
,constraint fk_review_member FOREIGN key (fk_member_num) REFERENCES member_table(member_num) on delete CASCADE
,constraint uq_review_orderProduct UNIQUE (fk_product_num, fk_order_num)
);

select * from review_table;
select * from review_image_table;

delete from review_table where review_num = 5;

update order_product_table set reviewFlag = 0
where fk_order_num = 2 and fk_product_num = 93;

commit;

select * from order_product_table;


insert into review_table(review_num, subject, content, hit, favorite, fk_product_num, fk_order_num, fk_member_num)
values(seq_review_table.nextval, '맛있어요', '이렇게 맛있는 음식은 처음이에요', 4, 2, 115, 1, 1);

select R.review_num, P.product_name, R.write_date, R.hit, R.favorite
	, R.subject, RI.image, R.content
from product_table P join review_table R
on P.product_num = R.fk_product_num
where R.fk_member_num = 3;

-- 후기테이블용 이미지 테이블 생성 --
create table review_image_table
(fk_review_num number not null
,image varchar2(100)
,constraint fk_review_image FOREIGN key (fk_review_num) REFERENCES review_table(review_num)
);


-- 리뷰테이블에 사용할 시퀀스 생성 --
create sequence seq_review_table
start with 1
increment by 1
nomaxvalue
nominvalue
nocycle
nocache;


-- 1:1문의 카테고리 테이블 생성 --
create table one_category_table
(category_num   number not null
,category_content varchar2(50)
,constraint pk_one_category primary key (category_num)
);



-- 1:1문의 테이블 생성 --
create table one_inquiry_table
(one_inquiry_num number not null    -- 1:1문의 게시글 번호
,subject    varchar2(50) not null   -- 문의 제목 필수
,content    varchar2(4000) not null -- 문의 내용 필수
,write_date date default sysdate    -- 작성날짜
,answer     varchar2(4000)          -- 관리자가 작성하는 답변
,emailFlag  number default 0
,smsFlag    number default 0
,fk_member_num  number not null     -- 회원테이블에서 회원번호를 참조하는 컬럼
,fk_order_num   number     -- 주문테이블에서 주문번호를 참조하는 컬럼
,fk_category_num number not null    -- 1:1문의 카테고리 테이블에서 카테고리번호를 참조하는 컬럼
,constraint pk_one_inquiry primary key (one_inquiry_num)
,constraint fk_one_member FOREIGN key (fk_member_num) REFERENCES member_table(member_num) on delete CASCADE
,constraint fk_one_order FOREIGN key (fk_order_num) REFERENCES order_table(order_num)
,constraint fk_one_category FOREIGN key (fk_category_num) REFERENCES one_category_table(category_num)
,constraint ck_one_emailCheck   check (emailFlag in(0,1))
,constraint ck_one_smsCheck check (smsFlag in (0,1))

);

-- 1:1문의 테이블에서 사용할 시퀀스 생성 --
create sequence seq_one_inquiry_table
start with 1
increment by 1
nomaxvalue
nominvalue
nocycle
nocache;

-- 공지사항 테이블 생성 --
create table notice_table
(notice_num number not null
,subject    varchar2(200) not null
,content    varchar2(4000) not null
,write_date date default sysdate
,hits   number default 0
,constraint pk_notice_table primary key (notice_num)
);

-- 공지사항 테이블에 사용할 시퀀스 생성 --
create sequence seq_notice_table
start with 1
increment by 1
nomaxvalue
nominvalue
nocycle
nocache;


-- 자주하는 질문 카테고리 테이블 생성 --
create table inquiry_category_table
(category_num   number not null
,category_content   varchar2(50)
,constraint pk_inquiry_category primary key (category_num)
);


-- 자주하는 질문 테이블 생성 --
create table FAQ_table
(FAQ_num number not null
,subject varchar2(200) not null
,content varchar2(4000) not null
,write_date date default sysdate
,hits   number default 0
,fk_category_num    number not null
,constraint pk_FAQ_table primary key(FAQ_num)
,constraint fk_FAQ_category FOREIGN key(fk_category_num) REFERENCES inquiry_category_table(category_num)
);


insert into inquiry_category_table(category_num, category_content) values(1, '회원문의');
insert into inquiry_category_table(category_num, category_content) values(2, '주문/결제');
insert into inquiry_category_table(category_num, category_content) values(3, '배송문의');
insert into inquiry_category_table(category_num, category_content) values(4, '서비스 이용 및 기타');

commit;




-- 자주하는 질문 테이블에서 사용할 시퀀스 생성 --
create sequence seq_FAQ_table
start with 1
increment by 1
nomaxvalue
nominvalue
nocycle
nocache;


delete from product_table;
commit;

select* from product_table;


-- 장바구니 테이블 --
create table basket_table
(basket_num     number not null
,product_count  number not null -- 주문한 상품의 갯수 필수
,fk_member_num  number not null -- 해당 장바구니에 상품을 담은 회원
,fk_product_num number not null -- 상품테이블의 상품번호를 참조하는 컬럼
,constraint fk_basket_product FOREIGN key (fk_product_num ) REFERENCES product_table(product_num)
,constraint fk_basket_member FOREIGN key (fk_member_num) REFERENCES member_table (member_num)
,constraint pk_basket_num primary key (basket_num)
);


select * from basket_table;

-- 장바구니 테이블에 사용할 시퀀스 생성 --
create sequence seq_basket_table
start with 1
increment by 1
nomaxvalue
nominvalue
nocycle
nocache;

-- 주문 상세 내역 정보(혜민)
select O.price,
M.name, to_char(O.order_date, 'yyyy-mm-dd hh24:mi:ss'), OS.order_state,
O.recipient, O.recipient_mobile, O.recipient_postcode, O.recipient_address, O.recipient_detailaddress, O.memo
from order_table O join member_table M
on O.fk_member_num = M.member_num 
join order_state_table OS
on O.fk_category_num = OS.category_num
where O.order_num = 1

-- 소고기
insert into product_table (product_num, product_name, price, stock, origin, packing, unit, seller, seller_phone, fk_category_num, fk_subcategory_num,
representative_img) 
values(seq_product_table.nextval, '1등급 한우 갈빗살 구이용 200g(냉장)', '31000', '10', '국내산(한우)', '냉장/종이포장', '1팩', '김진하', '01075653393', 4, 41,
'1등급 한우 갈빗살 구이용 200g(냉장).png');
insert into product_table (product_num, product_name, price, stock, origin, packing, unit, seller, seller_phone, fk_category_num, fk_subcategory_num,
representative_img) 
values(seq_product_table.nextval, '1등급 한우 목심 샤브샤브용 200g(냉장)', '32000', '10', '국내산(한우)', '냉장/종이포장', '1팩', '김진하', '01075653393', 4, 41,
'1등급 한우 목심 샤브샤브용 200g(냉장).png');
insert into product_table (product_num, product_name, price, stock, origin, packing, unit, seller, seller_phone, fk_category_num, fk_subcategory_num,
representative_img) 
values(seq_product_table.nextval, '1등급 한우 안심 추리 200g(냉장)', '35000', '4', '국내산(한우)', '냉장/종이포장', '1팩', '김진하', '01075653393', 4, 41,
'1등급 한우 안심 추리 200g(냉장).png');
insert into product_table (product_num, product_name, price, stock, origin, packing, unit, seller, seller_phone, fk_category_num, fk_subcategory_num,
representative_img) 
values(seq_product_table.nextval, '1등급 한우 알사태 수육용 500g(냉장)', '34000', '6', '국내산(한우)', '냉장/종이포장', '1팩', '김진하', '01075653393', 4, 41,
'1등급 한우 알사태 수육용 500g(냉장).png');
insert into product_table (product_num, product_name, price, stock, origin, packing, unit, seller, seller_phone, fk_category_num, fk_subcategory_num,
representative_img) 
values(seq_product_table.nextval, '1등급 한우 채끝 스키야끼용 200g(냉장)', '30000', '10', '국내산(한우)', '냉장/종이포장', '1팩', '김진하', '01075653393', 4, 41,
'1등급 한우 채끝 스키야끼용 200g(냉장).png');
insert into product_table (product_num, product_name, price, stock, origin, packing, unit, seller, seller_phone, fk_category_num, fk_subcategory_num,
representative_img) 
values(seq_product_table.nextval, '1등급 한우 홍두깨 육전용 200g(냉장)', '32000', '10', '국내산(한우)', '냉장/종이포장', '1팩', '김진하', '01075653393', 4, 41,
'1등급 한우 홍두깨 육전용 200g(냉장).png');
insert into product_table (product_num, product_name, price, stock, origin, packing, unit, seller, seller_phone, fk_category_num, fk_subcategory_num,
representative_img) 
values(seq_product_table.nextval, '와규 MB4+안심 스테이크 200g(냉장)', '33000', '8', '국내산(한우)', '냉장/종이포장', '1팩', '김진하', '01075653393', 4, 41,
'와규 MB4+안심 스테이크 200g(냉장).png');
insert into product_table (product_num, product_name, price, stock, origin, packing, unit, seller, seller_phone, fk_category_num, fk_subcategory_num,
representative_img) 
values(seq_product_table.nextval, '와규 MB4+채끝 스테이크 200g(냉장)', '33000', '10', '국내산(한우)', '냉장/종이포장', '1팩', '김진하', '01075653393', 4, 41,
'와규 MB4+채끝 스테이크 200g(냉장).png');
insert into product_table (product_num, product_name, price, stock, origin, packing, unit, seller, seller_phone, fk_category_num, fk_subcategory_num,
representative_img) 
values(seq_product_table.nextval, '초이스 찜갈비 2kg(냉동)', '58000', '5', '국내산(한우)', '냉동/종이포장', '1팩', '김진하', '01075653393', 4, 41,
'초이스 찜갈비 2kg(냉동).png');

commit;

delete from product_table
where origin = '국내산(한우)';

select*
from product_category_table;

select*
from product_subcategory_table;

select*
from product_subcategory_table
where subcategory_num like '4_';


commit;

select *
from product_table;


-- 소고기
insert into product_table (product_num, product_name, price, stock, origin, packing, unit, sale, seller, seller_phone, fk_category_num, fk_subcategory_num, representative_img) 
values(seq_product_table.nextval, '1등급 한우 갈빗살 구이용 200g(냉장)', '31000', '10', '국내산(한우)', '냉장/종이포장', '1팩', '10', '김진하', '01075653393', 4, 41, '1등급 한우 갈빗살 구이용 200g(냉장).png');
insert into product_table (product_num, product_name, price, stock, origin, packing, unit, sale, seller, seller_phone, fk_category_num, fk_subcategory_num, representative_img) 
values(seq_product_table.nextval, '1등급 한우 목심 샤브샤브용 200g(냉장)', '32000', '10', '국내산(한우)', '냉장/종이포장', '1팩', '0', '김진하', '01075653393', 4, 41, '1등급 한우 목심 샤브샤브용 200g(냉장).png');
insert into product_table (product_num, product_name, price, stock, origin, packing, unit, sale, seller, seller_phone, fk_category_num, fk_subcategory_num, representative_img) 
values(seq_product_table.nextval, '1등급 한우 안심 추리 200g(냉장)', '35000', '4', '국내산(한우)', '냉장/종이포장', '1팩', '0', '김진하', '01075653393', 4, 41, '1등급 한우 안심 추리 200g(냉장).png');
insert into product_table (product_num, product_name, price, stock, origin, packing, unit, sale, seller, seller_phone, fk_category_num, fk_subcategory_num, representative_img) 
values(seq_product_table.nextval, '1등급 한우 알사태 수육용 500g(냉장)', '34000', '6', '국내산(한우)', '냉장/종이포장', '1팩', '20', '김진하', '01075653393', 4, 41, '1등급 한우 알사태 수육용 500g(냉장).png');
insert into product_table (product_num, product_name, price, stock, origin, packing, unit, sale, seller, seller_phone, fk_category_num, fk_subcategory_num, representative_img) 
values(seq_product_table.nextval, '1등급 한우 채끝 스키야끼용 200g(냉장)', '30000', '10', '국내산(한우)', '냉장/종이포장', '1팩', '0', '김진하', '01075653393', 4, 41, '1등급 한우 채끝 스키야끼용 200g(냉장).png');
insert into product_table (product_num, product_name, price, stock, origin, packing, unit, sale, seller, seller_phone, fk_category_num, fk_subcategory_num, representative_img) 
values(seq_product_table.nextval, '1등급 한우 홍두깨 육전용 200g(냉장)', '32000', '10', '국내산(한우)', '냉장/종이포장', '1팩', '0', '김진하', '01075653393', 4, 41, '1등급 한우 홍두깨 육전용 200g(냉장).png');
insert into product_table (product_num, product_name, price, stock, origin, packing, unit, sale, seller, seller_phone, fk_category_num, fk_subcategory_num, representative_img) 
values(seq_product_table.nextval, '와규 MB4+안심 스테이크 200g(냉장)', '33000', '8', '국내산(한우)', '냉장/종이포장', '1팩', '10', '김진하', '01075653393', 4, 41, '와규 MB4+안심 스테이크 200g(냉장).png');
insert into product_table (product_num, product_name, price, stock, origin, packing, unit, sale, seller, seller_phone, fk_category_num, fk_subcategory_num, representative_img) 
values(seq_product_table.nextval, '와규 MB4+채끝 스테이크 200g(냉장)', '33000', '10', '국내산(한우)', '냉장/종이포장', '1팩', '30', '김진하', '01075653393', 4, 41, '와규 MB4+채끝 스테이크 200g(냉장).png');
insert into product_table (product_num, product_name, price, stock, origin, packing, unit, sale, seller, seller_phone, fk_category_num, fk_subcategory_num, representative_img) 
values(seq_product_table.nextval, '초이스 찜갈비 2kg(냉동)', '58000', '5', '국내산(한우)', '냉동/종이포장', '1팩', '0', '김진하', '01075653393', 4, 41, '초이스 찜갈비 2kg(냉동).png');


 select P.product_num as PRODUCT_NUM, c.category_content as CATEGORY_CONTENT,
             S.subcategory_content as SUBCATEGORY_CONTENT, P.product_name as PRODUCT_NAME,
             P.price as PRICE, P.stock as STOCK, p.sale as sale
 from product_table P join product_category_table C
 on P.fk_category_num = C.category_num
 join product_subcategory_table S
 on P.fk_subcategory_num = S.subcategory_num
 where fk_category_num =4 and fk_subcategory_num = 41 ;
 
  select P.product_num AS product_num, c.category_content AS category_content, 
             S.subcategory_content AS subcategory_content, P.product_name AS product_name,
             P.price AS price, P.stock AS stock, P.sale AS sale
 from product_table P JOIN product_category_table C 
 ON P.fk_category_num = C.category_num 
 JOIN product_subcategory_table S 
 on P.fk_subcategory_num = S.subcategory_num 
 where fk_category_num = 4 and fk_subcategory_num = 41; 



-- 돼지고기
insert into product_table (product_num, product_name, price, stock, origin, packing, unit, sale, seller, seller_phone, fk_category_num, fk_subcategory_num, representative_img) 
values(seq_product_table.nextval, '국내산 목살 양념구이', '12900', '15', '국내산', '냉동/종이포장', '1팩', '10', '김진하', '01075653393', 4, 42, '국내산 목살 양념구이.png');
insert into product_table (product_num, product_name, price, stock, origin, packing, unit, sale, seller, seller_phone, fk_category_num, fk_subcategory_num, representative_img) 
values(seq_product_table.nextval, '매콤한맛 삼겹살구이 (냉동)', '4900', '10', '돼지고기(브라질산)', '냉동/종이포장', '1팩', '10', '김진하', '01075653393', 4, 42, '매콤한맛 삼겹살구이 (냉동).png');
insert into product_table (product_num, product_name, price, stock, origin, packing, unit, sale, seller, seller_phone, fk_category_num, fk_subcategory_num, representative_img) 
values(seq_product_table.nextval, '무한생제 1등급 한동 다짐육 300g(냉장)', '58000', '5', '국내산', '냉장/종이포장', '1팩', '0', '김진하', '01075653393', 4, 42,  '무한생제 1등급 한동 다짐육 300g(냉장).png');
insert into product_table (product_num, product_name, price, stock, origin, packing, unit, sale, seller, seller_phone, fk_category_num, fk_subcategory_num, representative_img) 
values(seq_product_table.nextval, '바베큐맛 삼겹살구이 (냉동)', '4900', '12', '돼지고기(브라질산)', '냉동/종이포장', '1팩', '0', '김진하', '01075653393', 4, 42, '바베큐맛 삼겹살구이 (냉동).png');
insert into product_table (product_num, product_name, price, stock, origin, packing, unit, sale, seller, seller_phone, fk_category_num, fk_subcategory_num, representative_img) 
values(seq_product_table.nextval, '베요타 프레사 구이용 200g(냉동)', '18000', '14', '스페인산', '냉동/종이포장', '1팩', '20', '김진하', '01075653393', 4, 42, '베요타 프레사 구이용 200g(냉동).png');
insert into product_table (product_num, product_name, price, stock, origin, packing, unit, sale, seller, seller_phone, fk_category_num, fk_subcategory_num, representative_img) 
values(seq_product_table.nextval, '베요타 플루마 구이용 200g(냉동)', '18500', '10', '스페인산', '냉동/종이포장', '1팩', '0', '김진하', '01075653393', 4, 42, '베요타 플루마 구이용 200g(냉동).png');
insert into product_table (product_num, product_name, price, stock, origin, packing, unit, sale, seller, seller_phone, fk_category_num, fk_subcategory_num, representative_img) 
values(seq_product_table.nextval, '세보데깜뽀 플루마 구이용 200g(냉동)', '16500', '10', '스페인산', '냉동/종이포장', '1팩', '10', '김진하', '01075653393', 4, 42, '세보데깜뽀 플루마 구이용 200g(냉동).png');
insert into product_table (product_num, product_name, price, stock, origin, packing, unit, sale, seller, seller_phone, fk_category_num, fk_subcategory_num, representative_img) 
values(seq_product_table.nextval, '연저육찜', '15000', '6', '국내산', '냉장/종이포장', '1팩', '0', '김진하', '01075653393', 4, 42, '연저육찜.png');
insert into product_table (product_num, product_name, price, stock, origin, packing, unit, sale, seller, seller_phone, fk_category_num, fk_subcategory_num, representative_img) 
values(seq_product_table.nextval, '짭쪼름한맛 삼겹살구이 (냉동)', '4900', '15', '돼지고기(브라질산)', '냉동/종이포장', '1팩', '30', '김진하', '01075653393', 4, 42, '짭쪼름한맛 삼겹살구이 (냉동).png');



-- 닭고기
insert into product_table (product_num, product_name, price, stock, origin, packing, unit, sale, seller, seller_phone, fk_category_num, fk_subcategory_num,  representative_img) 
values(seq_product_table.nextval, 'BIG BITE 오키더키 2종', '5900', '10', '국내산', '냉장/종이포장', '1팩', '30', '김진하', '01075653393', 4, 43,  'BIG BITE 오키더키 2종.png');
insert into product_table (product_num, product_name, price, stock, origin, packing, unit, sale, seller, seller_phone, fk_category_num, fk_subcategory_num,  representative_img) 
values(seq_product_table.nextval, '골든치킨 봉', '7900', '10', '국내산', '냉동/종이포장', '1팩', '0', '김진하', '01075653393', 4, 43, '골든치킨 봉.png');
insert into product_table (product_num, product_name, price, stock, origin, packing, unit, sale, seller, seller_phone, fk_category_num, fk_subcategory_num,  representative_img) 
values(seq_product_table.nextval, '골든치킨 텐더스틱', '7400', '15', '국내산', '냉동/종이포장', '1팩', '20', '김진하',  '01075653393', 4, 43, '골든치킨 텐더스틱.png');
insert into product_table (product_num, product_name, price, stock, origin, packing, unit, sale, seller, seller_phone, fk_category_num, fk_subcategory_num,  representative_img) 
values(seq_product_table.nextval, '닭가슴살 큐브 스테이크 500g', '7900', '10', '국내산', '냉동/종이포장', '1팩', '0', '김진하', '01075653393', 4, 43, '닭가슴살 큐브 스테이크 500g.png');
insert into product_table (product_num, product_name, price, stock, origin, packing, unit, sale, seller, seller_phone, fk_category_num, fk_subcategory_num,  representative_img) 
values(seq_product_table.nextval, '닭한마리 칼국수 밀키트', '12000', '4', '국내산', '냉장/종이포장', '1팩', '20', '김진하',  '01075653393', 4, 43, '닭한마리 칼국수 밀키트.png');
insert into product_table (product_num, product_name, price, stock, origin, packing, unit, sale, seller, seller_phone, fk_category_num, fk_subcategory_num,  representative_img) 
values(seq_product_table.nextval, '동물복지 닭가슴살 큐브 스테이크 갈릭500g(냉동)', '7900', '10', '국내산', '냉동/종이포장', '1팩', '0', '김진하', '01075653393', 4, 43, '동물복지 닭가슴살 큐브 스테이크 갈릭500g(냉동).png' );
insert into product_table (product_num, product_name, price, stock, origin, packing, unit, sale, seller, seller_phone, fk_category_num, fk_subcategory_num,  representative_img) 
values(seq_product_table.nextval, '버팔로 치킨 봉 스파이시', '11000', '10', '국내산', '냉동/종이포장', '1팩', '20', '김진하', '01075653393', 4, 43, '버팔로 치킨 봉 스파이시.png');
insert into product_table (product_num, product_name, price, stock, origin, packing, unit, sale, seller, seller_phone, fk_category_num, fk_subcategory_num,  representative_img) 
values(seq_product_table.nextval, '사리듬뿍 순살 닭갈비 대용량', '16700', '10', '국내산', '냉장/종이포장', '1팩', '0', '김진하', '01075653393', 4, 43 , '사리듬뿍 순살 닭갈비 대용량.png');
insert into product_table (product_num, product_name, price, stock, origin, packing, unit, sale, seller, seller_phone, fk_category_num, fk_subcategory_num,  representative_img) 
values(seq_product_table.nextval, '유기농 치킨 커틀렛 300g', '4900', '15', '국내산', '냉동/종이포장', '1팩', '10', '김진하',  '01075653393', 4, 43, '유기농 치킨 커틀렛 300g.png');
insert into product_table (product_num, product_name, price, stock, origin, packing, unit, sale, seller, seller_phone, fk_category_num, fk_subcategory_num,  representative_img) 
values(seq_product_table.nextval, '초계 닭무침', '4300', '10', '국내산', '냉장/종이포장', '1팩', '0', '김진하', '01075653393', 4, 43, '초계 닭무침.png');
insert into product_table (product_num, product_name, price, stock, origin, packing, unit, sale, seller, seller_phone, fk_category_num, fk_subcategory_num,  representative_img) 
values(seq_product_table.nextval, '춘천식 닭갈비 밀키트', '13000', '11', '국내산', '냉장/종이포장', '1팩', '10', '김진하', '01075653393', 4, 43,  '춘천식 닭갈비 밀키트.png');
insert into product_table (product_num, product_name, price, stock, origin, packing, unit, sale, seller, seller_phone, fk_category_num, fk_subcategory_num,  representative_img) 
values(seq_product_table.nextval, '태양초 닭볶음탕 밀키트', '11000', '15', '국내산', '냉장/종이포장', '1팩', '30', '김진하', '01075653393', 4, 43,  '태양초 닭볶음탕 밀키트.png');

commit;

-- 수산 생선류
insert into product_table (product_num, product_name, price, stock, origin, packing, unit, sale, seller, seller_phone, fk_category_num, fk_subcategory_num,  representative_img) 
values(seq_product_table.nextval, '고추장굴비 200g(냉동)', '15900', '50', '국산', '냉동/종이포장', '1통', '0', '김진하', '01075653393', 3, 31, '고추장굴비 200g(냉동).png' );
insert into product_table (product_num, product_name, price, stock, origin, packing, unit, sale, seller, seller_phone, fk_category_num, fk_subcategory_num,  representative_img) 
values(seq_product_table.nextval, '동해손질가자미 350g(냉동)', '7900', '10', '국산', '냉동/종이포장', '1팩', '10', '김진하', '01075653393', 3, 31, '동해손질가자미 350g(냉동).png');
insert into product_table (product_num, product_name, price, stock, origin, packing, unit, sale, seller, seller_phone, fk_category_num, fk_subcategory_num,  representative_img) 
values(seq_product_table.nextval, '맘 아픈 굴비 1.4kg(20마리)(냉동)', '26500', '15', '국산', '냉동/종이포장', '1팩', '20', '김진하', '01075653393', 3, 31,  '맘 아픈 굴비 1.4kg(20마리)(냉동).png');
insert into product_table (product_num, product_name, price, stock, origin, packing, unit, sale, seller, seller_phone, fk_category_num, fk_subcategory_num,  representative_img) 
values(seq_product_table.nextval, '민물장어 2마리 450g내외(생물)', '45500', '20', '국산', '냉장/종이포장', '1팩', '0', '김진하', '01075653393', 3, 31, '민물장어 2마리 450g내외(생물).png');
insert into product_table (product_num, product_name, price, stock, origin, packing, unit, sale, seller, seller_phone, fk_category_num, fk_subcategory_num,  representative_img) 
values(seq_product_table.nextval, '바다장어 2마리 450g내외(생물)', '24900', '10', '국산', '냉장/종이포장', '1팩', '30', '김진하', '01075653393', 3, 31, '바다장어 2마리 450g내외(생물).png');

commit;

-- 수산 오징어
insert into product_table (product_num, product_name, price, stock, origin, packing, unit, sale, seller, seller_phone, fk_category_num, fk_subcategory_num,  representative_img) 
values(seq_product_table.nextval, '깨끗하게 손질된 오징어 두마리(생물)', '14900', '15', '국내산', '냉장/종이포장', '1팩', '30', '김진하', '01075653393', 3, 32, '깨끗하게 손질된 오징어 두마리(생물).png');
insert into product_table (product_num, product_name, price, stock, origin, packing, unit, sale, seller, seller_phone, fk_category_num, fk_subcategory_num,  representative_img) 
values(seq_product_table.nextval, '동해안 찜용 오징어 330g(냉동)', '11900', '22', '국내산', '냉장/종이포장', '1팩', '0', '김진하', '01075653393', 3, 32, '동해안 찜용 오징어 330g(냉동).png');
insert into product_table (product_num, product_name, price, stock, origin, packing, unit, sale, seller, seller_phone, fk_category_num, fk_subcategory_num,  representative_img) 
values(seq_product_table.nextval, '모리타니산 자숙문어 한마리(냉동)', '27000', '33', '모리타니산', '냉동/종이포장', '1마리', '20', '김진하', '01075653393', 3, 32, '모리타니산 자숙문어 한마리(냉동).png');
insert into product_table (product_num, product_name, price, stock, origin, packing, unit, sale, seller, seller_phone, fk_category_num, fk_subcategory_num,  representative_img) 
values(seq_product_table.nextval, '문어 슬라이스 120g(냉장)', '9900', '26', '모리타니산', '냉장/종이포장', '1팩', '0', '김진하', '01075653393', 3, 32, '문어 슬라이스 120g(냉장).png');
insert into product_table (product_num, product_name, price, stock, origin, packing, unit, sale, seller, seller_phone, fk_category_num, fk_subcategory_num,  representative_img) 
values(seq_product_table.nextval, '손질 통오징어', '8300', '30', '국산', '냉동/종이포장', '1팩', '10', '김진하', '01075653393', 3, 32, '손질 통오징어.png');


-- 수산 새우 게
insert into product_table (product_num, product_name, price, stock, origin, packing, unit, sale, seller, seller_phone, fk_category_num, fk_subcategory_num,  representative_img)
values(seq_product_table.nextval, '갓 잡아올린 신선한 생새우', '18900', '10', '국산', '냉장/종이포장', '1팩', '0', '김진하', '01075653393', 3, 33,  '갓 잡아올린 신선한 생새우.png');
insert into product_table (product_num, product_name, price, stock, origin, packing, unit, sale, seller, seller_phone, fk_category_num, fk_subcategory_num,  representative_img)
values(seq_product_table.nextval, '손질 가을수꽃게 6조각(중 300~400g)(냉동)', '14900', '15', '국산', '냉동/종이포장', '1팩', '30', '김진하', '01075653393', 3, 33, '손질 가을수꽃게 6조각(중 300~400g)(냉동).png' );
insert into product_table (product_num, product_name, price, stock, origin, packing, unit, sale, seller, seller_phone, fk_category_num, fk_subcategory_num,  representative_img)
values(seq_product_table.nextval, '싱싱 흰다리새우(중 220~270g)(냉동)', '10500', '15', '국산', '냉동/종이포장', '1팩', '20', '김진하', '01075653393', 3, 33, '싱싱 흰다리새우(중 220~270g)(냉동).png');

commit;

-- 채소 기본채소
insert into product_table (product_num, product_name, price, stock, origin, packing, unit, sale, seller, seller_phone, fk_category_num, fk_subcategory_num,  representative_img)
values(seq_product_table.nextval, '친환경 미니 밤호박 (보짱) 1개', '4300', '10', '국산', '냉장/종이포장', '1개', '0', '김은혜', '01012345678', 1, 11, '친환경 미니 밤호박 (보짱) 1개.jpg');

insert into product_table (product_num, product_name, price, stock, origin, packing, unit, sale, seller, seller_phone, fk_category_num, fk_subcategory_num,  representative_img)
values(seq_product_table.nextval, '피클오이(러스보이) 6입', '4300', '10', '국산', '냉장/종이포장', '1팩', '10', '김은혜', '01012345678', 1, 11, '피클오이(러스보이) 6입.jpg');

insert into product_table (product_num, product_name, price, stock, origin, packing, unit, sale, seller, seller_phone, fk_category_num, fk_subcategory_num,  representative_img)
values(seq_product_table.nextval, '통마늘 1kg', '7500', '20', '국산', '냉장/종이포장', '1망', '10', '김은혜', '01012345678', 1, 11, '통마늘 1kg.jpg');

insert into product_table (product_num, product_name, price, stock, origin, packing, unit, sale, seller, seller_phone, fk_category_num, fk_subcategory_num,  representative_img)
values(seq_product_table.nextval, '초당 옥수수 5입', '10900', '30', '국산', '냉장/종이포장', '1망', '0', '김은혜', '01012345678', 1, 11, '초당 옥수수 5입.jpg');

insert into product_table (product_num, product_name, price, stock, origin, packing, unit, sale, seller, seller_phone, fk_category_num, fk_subcategory_num,  representative_img)
values(seq_product_table.nextval, '찰 옥수수 5입 망', '7990', '30', '국산', '냉장/종이포장', '1망', '10', '김은혜', '01012345678', 1, 11, '찰 옥수수 5입 망.jpg');


-- 채소 쌈 샐러드
insert into product_table (product_num, product_name, price, stock, origin, packing, unit, sale, seller, seller_phone, fk_category_num, fk_subcategory_num,  representative_img)
values(seq_product_table.nextval, '[간편 샐러드] 손질 치커리 40g', '1850', '20', '국산', '냉장/종이포장', '1팩','10', '김은혜', '01012345678', 1, 12, '손질 치커리 40g.jpg');

insert into product_table (product_num, product_name, price, stock, origin, packing, unit, sale, seller, seller_phone, fk_category_num, fk_subcategory_num,  representative_img)
values(seq_product_table.nextval, '[소중한식사] 닭 스프링롤 키트', '8900', '20', '국산', '냉장/종이포장', '1팩','10', '김은혜', '01012345678', 1, 12, '닭 스프링롤 키트.jpg');

insert into product_table (product_num, product_name, price, stock, origin, packing, unit, sale, seller, seller_phone, fk_category_num, fk_subcategory_num,  representative_img)
values(seq_product_table.nextval, '[소중한식사] 새우 스프링롤 키트', '8900', '10', '국산', '냉장/종이포장', '1팩','0', '김은혜', '01012345678', 1, 12, '새우 스프링롤 키트.jpg');

insert into product_table (product_num, product_name, price, stock, origin, packing, unit, sale, seller, seller_phone, fk_category_num, fk_subcategory_num,  representative_img)
values(seq_product_table.nextval, '[소중한식사] 스프링롤 키트', '7900', '10', '국산', '냉장/종이포장', '1팩','10', '김은혜', '01012345678', 1, 12, '스프링롤 키트.jpg');

insert into product_table (product_num, product_name, price, stock, origin, packing, unit, sale, seller, seller_phone, fk_category_num, fk_subcategory_num,  representative_img)
values(seq_product_table.nextval, '무농약 롤로비온다 80g', '4200', '10', '국산', '냉장/종이포장', '1팩','0', '김은혜', '01012345678', 1, 12, '무농약 롤로비온다 80g.jpg');


-- 특수채소
insert into product_table (product_num, product_name, price, stock, origin, packing, unit, sale, seller, seller_phone, fk_category_num, fk_subcategory_num,  representative_img)
values(seq_product_table.nextval, '고수 30g', '1590', '25', '국산', '냉장/종이포장', '1팩','10','김은혜', '01012345678', 1, 13, '고수 30g.jpg');

insert into product_table (product_num, product_name, price, stock, origin, packing, unit, sale, seller, seller_phone, fk_category_num, fk_subcategory_num,  representative_img)
values(seq_product_table.nextval, '딜 10g', '1590', '16', '국산', '냉장/종이포장', '1팩','10', '김은혜', '01012345678', 1, 13, '딜 10g.jpg');

insert into product_table (product_num, product_name, price, stock, origin, packing, unit, sale, seller, seller_phone, fk_category_num, fk_subcategory_num,  representative_img)
values(seq_product_table.nextval, '애플민트 10g', '1450', '17', '국산', '냉장/종이포장', '1팩','0', '김은혜', '01012345678', 1, 13,'애플민트 10g.jpg');

insert into product_table (product_num, product_name, price, stock, origin, packing, unit, sale, seller, seller_phone, fk_category_num, fk_subcategory_num,  representative_img)
values(seq_product_table.nextval, '로즈마리 10g', '1400', '10', '국산', '냉장/종이포장', '1팩','0', '김은혜', '01012345678', 1, 13, '로즈마리 10g.jpg');

insert into product_table (product_num, product_name, price, stock, origin, packing, unit, sale, seller, seller_phone, fk_category_num, fk_subcategory_num,  representative_img)
values(seq_product_table.nextval, '이탈리안 파슬리 15g', '1350', '18', '국산', '냉장/종이포장', '1팩','10', '김은혜', '01012345678', 1, 13, '이탈리안 파슬리 15g.jpg');

insert into product_table (product_num, product_name, price, stock, origin, packing, unit, sale, seller, seller_phone, fk_category_num, fk_subcategory_num,  representative_img)
values(seq_product_table.nextval, '화이트 아스파라거스 200g', '8900', '18', '페루산', '냉장/종이포장', '1팩','0', '김은혜', '01012345678', 1, 13, '화이트 아스파라거스 200g.jpg');

commit;

---- 과일 견과 국산
insert into product_table (product_num, product_name, price, stock, origin, packing, unit, sale, seller, seller_phone, fk_category_num, fk_subcategory_num,  representative_img)
values(seq_product_table.nextval, '유기농 블루베리 2종', '4900', '15', '국산', '냉장/종이포장', '1팩','10', '이주명', '01056785678', 2, 21,'유기농 블루베리 2종.jpg');
insert into product_table (product_num, product_name, price, stock, origin, packing, unit, sale, seller, seller_phone, fk_category_num, fk_subcategory_num,  representative_img)
values(seq_product_table.nextval, '[네떼] 시원할수박에 700g', '8900', '15', '국산', '냉장/종이포장', '1팩','0', '이주명', '01056785678', 2, 21, '시원할수박에 700g.jpg');
insert into product_table (product_num, product_name, price, stock, origin, packing, unit, sale, seller, seller_phone, fk_category_num, fk_subcategory_num,  representative_img)
values(seq_product_table.nextval, 'GAP 거봉포도 1팩', '12500', '20', '국산', '냉장/종이포장', '1팩','10', '이주명', '01056785678', 2, 21, 'GAP 거봉포도 1팩.jpg');
insert into product_table (product_num, product_name, price, stock, origin, packing, unit, sale, seller, seller_phone, fk_category_num, fk_subcategory_num,  representative_img)
values(seq_product_table.nextval, 'GAP 천도복숭아 950g', '11950', '20', '국산', '냉장/종이포장', '1팩','0', '이주명', '01056785678', 2, 21, 'GAP 천도복숭아 950g.jpg');
insert into product_table (product_num, product_name, price, stock, origin, packing, unit, sale, seller, seller_phone, fk_category_num, fk_subcategory_num,  representative_img)
values(seq_product_table.nextval, '고당도 흑미 수박 7kg', '23800', '20', '국산', '냉장/종이포장', '1통', '0','이주명', '01056785678', 2, 21, '고당도 흑미 수박 7kg.jpg');


-- 과일 수입과일
insert into product_table (product_num, product_name, price, stock, origin, packing, unit, sale, seller, seller_phone, fk_category_num, fk_subcategory_num,  representative_img)
values(seq_product_table.nextval, '[Dole] 그린 파파야 1개', '4400', '15', '필리핀', '냉장/종이포장', '1개', '0','이주명', '01056785678', 2, 22, '그린 파파야 1개.jpg');
insert into product_table (product_num, product_name, price, stock, origin, packing, unit, sale, seller, seller_phone, fk_category_num, fk_subcategory_num,  representative_img)
values(seq_product_table.nextval, '[Dole] 스위티오 파인애플 스틱 80g', '1650', '15', '파인애플:필리핀산/제조국:대한민국', '냉장/종이포장', '1봉','0', '이주명', '01056785678', 2, 22, '스위티오 파인애플 스틱 80g.jpg');
insert into product_table (product_num, product_name, price, stock, origin, packing, unit, sale, seller, seller_phone, fk_category_num, fk_subcategory_num,  representative_img)
values(seq_product_table.nextval, '[Dole] 스위티오 파인애플 슬라이스 540g', '6900', '15', '파인애플:필리핀산/제조국:대한민국', '냉장/종이포장', '1팩','10', '이주명', '01056785678', 2, 22, '스위티오 파인애플 슬라이스 540g.jpg');
insert into product_table (product_num, product_name, price, stock, origin, packing, unit, sale, seller, seller_phone, fk_category_num, fk_subcategory_num,  representative_img)
values(seq_product_table.nextval, '[Dole] 파파야 1개', '4400', '15', '필리핀', '냉장/종이포장', '1개','0', '이주명', '01056785678', 2, 22, '파파야 1개.jpg');
insert into product_table (product_num, product_name, price, stock, origin, packing, unit, sale, seller, seller_phone, fk_category_num, fk_subcategory_num,  representative_img)
values(seq_product_table.nextval, '[KF365] 아보카도 1개', '3300', '15', '미국산', '냉장/종이포장', '1개','0', '이주명', '01056785678', 2, 22, '아보카도 1개.jpg');


-- 과일 냉동 건과일
insert into product_table (product_num, product_name, price, stock, origin, packing, unit, sale, seller, seller_phone, fk_category_num, fk_subcategory_num,  representative_img)
values(seq_product_table.nextval, '[델루츠] 소포장 냉동과일 3종', '1980', '15', '제품 별도표기', '냉동/종이포장', '1봉','0', '이주명', '01056785678', 2, 23, '소포장 냉동과일 3종.jpg');
insert into product_table (product_num, product_name, price, stock, origin, packing, unit, sale, seller, seller_phone, fk_category_num, fk_subcategory_num,  representative_img)
values(seq_product_table.nextval, '[선물세트] 곶감 세트', '75000', '10', '국산', '기타', '1박스','20', '이주명', '01056785678', 2, 23, '곶감 세트.jpg');
insert into product_table (product_num, product_name, price, stock, origin, packing, unit, sale, seller, seller_phone, fk_category_num, fk_subcategory_num,  representative_img)
values(seq_product_table.nextval, '[아르도] 냉동과일 퓨레1kg 2종', '16500', '15', '제품 별도표기', '냉동/종이포장', '1봉','0', '이주명', '01056785678', 2, 23, '냉동과일 퓨레1kg 2종.jpg');
insert into product_table (product_num, product_name, price, stock, origin, packing, unit, sale, seller, seller_phone, fk_category_num, fk_subcategory_num,  representative_img)
values(seq_product_table.nextval, '[유가원] 베리베리 믹스 140g', '8800', '10', '제품 별도표기', '냉동/종이포장', '1통','0', '이주명', '01056785678', 2, 23, '베리베리 믹스 140g.jpg');
insert into product_table (product_num, product_name, price, stock, origin, packing, unit, sale, seller, seller_phone, fk_category_num, fk_subcategory_num,  representative_img)
values(seq_product_table.nextval, '[인비바] 과일칩 4종', '3200', '10', '제품 별도표기', '상온/종이포장', '1팩','10', '이주명', '01056785678', 2, 23, '과일칩 4종.jpg');

commit;
     
-- 음료 생수 음료 주스(원산지x)
insert into product_table (product_num, product_name, price, stock, packing, unit, sale, seller, seller_phone, fk_category_num, fk_subcategory_num,  representative_img)
values(seq_product_table.nextval, '[그래미] 여명 808', '8450', '20', '상온/종이포장', '1박스','0', '이주명', '01056785678', 5, 51, '여명 808.jpg');
insert into product_table (product_num, product_name, price, stock, packing, unit, sale, seller, seller_phone, fk_category_num, fk_subcategory_num,  representative_img)
values(seq_product_table.nextval, '[바로이즙] ABC 착즙주스 2종', '11000', '20', '상온/종이포장', '1박스','10', '이주명', '01056785678', 5, 51, 'ABC 착즙주스 2종.jpg');
insert into product_table (product_num, product_name, price, stock, packing, unit, sale, seller, seller_phone, fk_category_num, fk_subcategory_num,  representative_img)
values(seq_product_table.nextval, '[산타니올] 스페인 클래식 탄산수 750ml 1박스 (6개입)', '19980', '10', '상온/종이포장', '1박스','0', '이주명', '01056785678', 5, 51, '스페인 클래식 탄산수 750ml 1박스 (6개입).jpg');
insert into product_table (product_num, product_name, price, stock, packing, unit, sale, seller, seller_phone, fk_category_num, fk_subcategory_num,  representative_img)
values(seq_product_table.nextval, '[산토리니] 스파클링 4종 (묶음)', '11900', '10', '상온/종이포장', '1박스','10', '이주명', '01056785678', 5, 51, '스파클링 4종 (묶음).jpg');
insert into product_table (product_num, product_name, price, stock, packing, unit, sale, seller, seller_phone, fk_category_num, fk_subcategory_num,  representative_img)
values(seq_product_table.nextval, '[오늘의 일상] 에이드 베이스 4종', '16000', '10', '냉장/종이포장', '1병','0', '이주명', '01056785678', 5, 51, '에이드 베이스 4종.jpg');

-- 음료 커피 차
insert into product_table (product_num, product_name, price, stock, packing, unit, sale, seller, seller_phone, fk_category_num, fk_subcategory_num,  representative_img)
values(seq_product_table.nextval, '[모모스커피] RTD 콜드브루 (에스 쇼콜라)', '4500', '20', '냉장/종이포장', '1캔','0', '이주명', '01056785678', 5, 52,'RTD 콜드브루 (에스 쇼콜라).jpg');
insert into product_table (product_num, product_name, price, stock, packing, unit, sale, seller, seller_phone, fk_category_num, fk_subcategory_num,  representative_img)
values(seq_product_table.nextval, '[모모스커피] RTD 콜드브루 (에티오피아)', '4500', '20', '냉장/종이포장', '1캔','0', '이주명', '01056785678', 5, 52, 'RTD 콜드브루 (에티오피아).jpg');
insert into product_table (product_num, product_name, price, stock, packing, unit, sale, seller, seller_phone, fk_category_num, fk_subcategory_num,  representative_img)
values(seq_product_table.nextval, '[모모스커피] RTD 콜드브루 (파나마 펄시 게샤)', '4500', '20', '냉장/종이포장', '1캔','0', '이주명', '01056785678', 5, 52, 'RTD 콜드브루 (파나마 펄시 게샤).jpg');
insert into product_table (product_num, product_name, price, stock, packing, unit, sale, seller, seller_phone, fk_category_num, fk_subcategory_num,  representative_img)
values(seq_product_table.nextval, '[연경재] 냉침커피 트로픽가드너(Tropic Gardener)', '4000', '10', '냉장/종이포장', '1캔','0', '이주명', '01056785678', 5, 52, '냉침커피 트로픽가드너(Tropic Gardener).jpg');
insert into product_table (product_num, product_name, price, stock, origin, packing, unit, sale, seller, seller_phone, fk_category_num, fk_subcategory_num,  representative_img)
values(seq_product_table.nextval, '[연경재] 커피원두 젤리빈(Jelly Bean)', '25000', '10', '콜롬비아', '상온/종이포장', '1캔','0', '이주명', '01056785678', 5, 52, '커피원두 젤리빈(Jelly Bean).jpg'); -- 원산지 있음
     
-- 음료 우유 두유 요거트
insert into product_table (product_num, product_name, price, stock, origin, packing, unit, sale, seller, seller_phone, fk_category_num, fk_subcategory_num,  representative_img)
values(seq_product_table.nextval, '[Kurlys] 동물복지 우유 900ml', '2650', '10', '국내산', '냉장/종이포장', '1팩','0', '이주명', '01056785678', 5, 53, '동물복지 우유 900ml.jpg');
insert into product_table (product_num, product_name, price, stock, packing, unit, sale, seller, seller_phone, fk_category_num, fk_subcategory_num,  representative_img)
values(seq_product_table.nextval, '[매일] 바이오 플레인 요거트 2종', '2980', '10', '냉장/종이포장', '1통','0', '이주명', '01056785678', 5, 53, '바이오 플레인 요거트 2종.jpg');
insert into product_table (product_num, product_name, price, stock, packing, unit, sale, seller, seller_phone, fk_category_num, fk_subcategory_num,  representative_img)
values(seq_product_table.nextval, '[매일] 오리지널 우유 1.5L', '3980', '5', '냉장/종이포장', '1통','0', '이주명', '01056785678', 5, 53, '오리지널 우유 1.5L.jpg');
insert into product_table (product_num, product_name, price, stock, packing, unit, sale, seller, seller_phone, fk_category_num, fk_subcategory_num,  representative_img)
values(seq_product_table.nextval, '[매일] 저지방 우유 1.5L', '3980', '5', '냉장/종이포장', '1통', '0','이주명', '01056785678', 5, 53, '저지방 우유 1.5L.jpg');
insert into product_table (product_num, product_name, price, stock, packing, unit, sale, seller, seller_phone, fk_category_num, fk_subcategory_num,  representative_img)
values(seq_product_table.nextval, '[베지밀] 건강맘 두유', '14000', '10', '상온/종이포장', '1박스','10', '이주명', '01056785678', 5, 53, '건강맘 두유.jpg');

commit;


select RON, product_name, sale from
(select rownum as RON, product_name, sale from
    (select product_num, product_name, price, stock, sale, to_char(registerdate,'yyyy-mm-dd') as registerdate from product_table))T
    where T.RON between 1 and 8;
    
    
    
select P.product_num, P.product_name, P.price, P.stock, P.origin, P.packing, P.unit, C.category_content , S.subcategory_content
from product_table P join product_category_table C 
on P.fk_category_num = C.category_num 
join product_subcategory_table S
on P.fk_subcategory_num = S.subcategory_num
join product_detail_table D 
on P.product_num = D.fk_product_num;

select * from product_table;

insert into product_detail_table (fk_product_num, representative_image, explain)
values(1,'1등급 한우 갈빗살 구이용 200g(냉장).png','1등급 한우 갈빗살');
insert into product_detail_table (fk_product_num, representative_image, explain)
values(2,'1등급 한우 목심 샤브샤브용 200g(냉장).png','1등급 한우 목심');
insert into product_detail_table (fk_product_num, representative_image, explain)
values(3,'1등급 한우 안심 추리 200g(냉장).png','1등급 한우 안심');
insert into product_detail_table (fk_product_num, representative_image, explain)
values(4,'1등급 한우 알사태 수육용 500g(냉장).png','1등급 한우 알사태');





select * from product_category_table union select * from product_subcategory_table;

insert into member_table (member_num, name, userid, pwd, email, mobile, status) 
values (seq_member_table.nextval, '관리자', 'admin', 'qwer1234!','2wnaud@naver.com','010-9101-8698','2');

commit;


select * from member_table;
update member_table set status=2 where userid='admin1';

commit;

delete from member_table;

select count(*) from basket_table where fk_member_num = ;

-- 주문 내역(혜민)
select O.order_num
     , O.to_char(order_date,'yyyy.mm.dd hh24:mi:ss')
     , O.price
     , OP.fk_product_num
     , P.product_name
     , P.representative_img
     , OS.order_state 
from order_table O join order_product_table OP 
on O.order_num = OP.fk_order_num join order_state_table OS 
on O.fk_category_num = OS.category_num join product_table P 
on OP.fk_product_num = P.product_num
where O.fk_member_num = ?
+
select count(*) from order_product_table where fk_order_num = ?





select  RNO, PRODUCT_NUM, CATEGORY_CONTENT, SUBCATEGORY_CONTENT, PRODUCT_NAME, PRICE, STOCK 
from 
    ( select rownum AS RNO,PRODUCT_NUM, CATEGORY_CONTENT, SUBCATEGORY_CONTENT, PRODUCT_NAME, PRICE, STOCK
        from 
          ( select P.PRODUCT_NUM, c.category_content as CATEGORY_CONTENT, 
                    S.subcategory_content as SUBCATEGORY_CONTENT, P.PRODUCT_NAME,
                    P.PRICE, P.STOCK
            from ( select product_num as PRODUCT_NUM, fk_category_num, fk_subcategory_num, product_name as PRODUCT_NAME, price as PRICE, stock as STOCK
                    from product_table
                    where fk_category_num = 3 and product_name like '%'||''||'%')
            P join product_category_table C
            on P.fk_category_num = C.category_num 
            join product_subcategory_table S
            on P.fk_subcategory_num = S.subcategory_num
            order by PRODUCT_NUM desc
            )V
		)T;
where T.RNO between 1 and 10;



select ceil(count(*)/10) as totalPage
from product_table
where FK_CATEGORY_NUM = 3 and product_name like '%'||'오징어'||'%';
                        




insert into member_table(member_num, name, userid, address, pwd, email, hp1, hp2, hp3) values (seq_member_table.nextval, '미미','mimi','인천 남동구 구월동','qwer1234!','abcd@naver.com','010','1234','5678');
insert into member_table(member_num, name, userid, address, pwd, email, hp1, hp2, hp3) values (seq_member_table.nextval, '미미미','mimimi','서울 남동구 구월동','qwer1234!','mimimi@naver.com','010','1234','5678');
insert into member_table(member_num, name, userid, address, pwd, email, hp1, hp2, hp3) values (seq_member_table.nextval, '미미미미','mimimimi','인천 구월1동','qwer1234!','mimimimi@naver.com','010','1234','5678');
insert into member_table(member_num, name, userid, address, pwd, email, hp1, hp2, hp3) values (seq_member_table.nextval, '나나','nana','서울 강남구','qwer1234!','nana@naver.com','010','1234','5678');
insert into member_table(member_num, name, userid, address, pwd, email, hp1, hp2, hp3) values (seq_member_table.nextval, '나나나','nanana','부산광역시 동래구 사직로 77 ','qwer1234!','nanana@naver.com','010','1234','5678');
insert into member_table(member_num, name, userid, address, pwd, email, hp1, hp2, hp3) values (seq_member_table.nextval, '라라','rara','인천광역시','qwer1234!','rara@naver.com','010','1234','5678');
insert into member_table(member_num, name, userid, address, pwd, email, hp1, hp2, hp3) values (seq_member_table.nextval, '라라라','rarara','서울','qwer1234!','rarara@naver.com','010','1234','5678');
insert into member_table(member_num, name, userid, address, pwd, email, hp1, hp2, hp3) values (seq_member_table.nextval, '김웅앵','kim','우리동네','qwer1234!','kim@naver.com','010','1234','5678');
insert into member_table(member_num, name, userid, address, pwd, email, hp1, hp2, hp3) values (seq_member_table.nextval, '이웅앵','lee','너네동네','qwer1234!','lee@naver.com','010','1234','5678');
insert into member_table(member_num, name, userid, address, pwd, email, hp1, hp2, hp3) values (seq_member_table.nextval, '야야','yaya','','qwer1234!','yaya@naver.com','010','1234','5678');
insert into member_table(member_num, name, userid, pwd, email, hp1, hp2, hp3) values (seq_member_table.nextval, '김라라','kimrara','qwer1234','kimraraabcd@naver.com','010','1234','5678');

commit;

select*
from member_table;


select ceil(count(*)/10) as totalPage
from member_table
where userid like '%'||'mimi'||'%' ;


select member_num, name, userid, address				
from member_table ;
order by member_num desc;


select * from member_table where email='28b68acc3cb16bb4484f15c844477637c2f615e6e0b874cb1bbc87490160a50f';
select email from member_table;

commit;


select nvl(sum(oqty * saleprice), 0) AS SUMTOTALPRICE
     , nvl(sum(oqty * point), 0) AS SUMTOTALPOINT
from shopping_cart A join shopping_product B
on A.fk_pnum = B.pnum
where status = 1 and fk_userid = 'hongkd';

select nvl(sum(product_count *  (price - price * (sale/100) ) ), 0 ) AS SUMTOTALPRICE
from basket_table A join product_table B
on A.fk_product_num = B.product_num
where  A.fk_member_num = ?;

select nvl(sum(2 *  (34000 - 34000 * (20/100) ) ), 0 ) 
from dual;

select * from order_product_table OP
join order_table O on OP.fk_order_num = O.order_num
join member_table M on O.fk_member_num = M.member_num
join product_table P on OP.fk_product_num = P.product_num
join product_category_table PC on P.fk_category_num = PC.category_num
join product_subcategory_table PS on P.fk_subcategory_num = PS.subcategory_num
where OP.reviewFlag = 0 and O.fk_category_num = 1;

select * from order_table;

insert into one_category_table(category_num, category_content) values(1, '배송지연/불만');
insert into one_category_table(category_num, category_content) values(2, '컬리패스(무료배송)');
insert into one_category_table(category_num, category_content) values(3, '반품문의');
insert into one_category_table(category_num, category_content) values(4, 'A/S문의');
insert into one_category_table(category_num, category_content) values(5, '환불문의');
insert into one_category_table(category_num, category_content) values(6, '주문결제문의');
insert into one_category_table(category_num, category_content) values(7, '회원정보문의');
insert into one_category_table(category_num, category_content) values(8, '취소문의');
insert into one_category_table(category_num, category_content) values(9, '교환문의');
insert into one_category_table(category_num, category_content) values(10, '상품정보문의');
insert into one_category_table(category_num, category_content) values(11, '기타문의');

commit;

create table basket_table
(basket_num     number not null
,product_count  number not null -- 주문한 상품의 갯수 필수
,fk_member_num  number not null -- 해당 장바구니에 상품을 담은 회원
,fk_product_num number not null -- 상품테이블의 상품번호를 참조하는 컬럼
,constraint fk_basket_product FOREIGN key (fk_product_num ) REFERENCES product_table(product_num)
,constraint fk_basket_member FOREIGN key (fk_member_num) REFERENCES member_table (member_num)
,constraint pk_basket_num primary key (basket_num)
);

select * from basket_table;