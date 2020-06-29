show user;
-- USER이(가) "SEMIORAUSER1"입니다.

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
,status     number(1) default 1 -- 회원상태(1 일반회원, 2 관리자, 0 휴면상태)
,constraint pk_member_table PRIMARY KEY (member_num)
,constraint uq_member_table_userid UNIQUE(userid)
,constraint uq_member_table_email unique(email)
,constraint ck_member_table_gender CHECK (gender in (0,1,2))
,constraint ck_member_table_status CHECK (status in(0,1,2))
);


-- 회원테이블에 사용할 시퀀스 생성 --
create sequence seq_member_table
start with 1
increment by 1
nomaxvalue
nominvalue
nocycle
nocache;

select *
from member_table;

-- 상품 대분류 카테고리 테이블 생성 --
create table product_category_table
( category_num  number            -- 대분류 카테고리 번호 필수+고유
, category_content  varchar2(50)  -- 번호에 해당하는 실제 표시할 내용
,constraint pk_category_num primary key (category_num)
);


insert into product_category_table(category_num, category_content) values(1,'채소');
insert into product_category_table(category_num, category_content) values(2,'과일 견과');
insert into product_category_table(category_num, category_content) values(3,'수산 해산');
insert into product_category_table(category_num, category_content) values(4,'정육');
insert into product_category_table(category_num, category_content) values(5,'음료 우유');



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

select * from product_category_table;
select * from product_subcategory_table;


-- 상품 테이블 생성 --
create table product_table
(product_num    number not null -- 상품번호 필수+고유 시퀀스 사용
,product_name   varchar2(50) not null -- 상품이름 필수+고유
,price          number  not null -- 가격 필수
,stock          number not null -- 재고 필수
,origin         varchar2(50) -- 원산지
,packing      varchar2(80) -- 포장방법
,unit           varchar2(50) -- 단위
,registerdate   date default sysdate -- 등록날짜
,sale           number default 0 -- 세일 %값
,best_point     number -- 관리자가 추천하는 수 (MD추천)
,seller         varchar2(50) -- 판매자(관리자 모드시에 사용)
,seller_phone   varchar2(80) -- 판매자 번호(관리자 모드시에 사용)
,explain    varchar2(4000) -- 상품설명
,representative_img varchar2(100) not null
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

-- 상품 이미지와 설명 테이블 생성 --
create table product_image_table
(fk_product_num number not null -- 상품테이블에 있는 상품번호를 참조받는 컬럼
,image  varchar2(100)
,constraint fk_prodcut_detail_num FOREIGN key (fk_product_num) REFERENCES product_table(product_num) on DELETE CASCADE
);


-- 상품문의 테이블 생성 --
create table product_inquiry_table
(inquiry_num    number not null     -- 상품문의 번호 필수+고유 시퀀스 사용
,subject    varchar2(50) not null   -- 제목 필수
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
,constraint fk_inquiry_image FOREIGN key (fk_inquiry_num) REFERENCES product_inquiry_table(inquiry_num)
);

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
(category_num   number  not null -- 배송상태 카테고리 번호
,order_state    varchar2(50) -- 번호에 해당하는 실제 내용
,constraint pk_order_state  primary key(category_num)
);


-- 주문 정보 테이블 생성 --
create table order_table
(order_num  number  not null    -- 주문번호 필수+고유 시퀀스 사용
,order_date date default sysdate    -- 주문날짜
,recipient  varchar2(50) not null   -- 받는 사람 필수
,recipient_mobile   varchar2(100) not null  -- 받는 사람의 연락처 필수
,recipient_postcode varchar2(100) not null  -- 받는 사람의 우편번호
,recipient_address  varchar2(100) not null  -- 받는 사람의 주소
,recipient_detailaddress varchar2(100) not null -- 받는 사람의 상세주소
,price  number  not null    -- 주문금액 필수
,memo   varchar2(200)       -- 요청사항
,fk_member_num  number  not null    -- 회원테이블의 회원번호를 참조하는 컬럼
,fk_category_num number not null    -- 주문상태 케이블의 주문상태 번호를 참조하는 컬럼
,constraint pk_order_table  primary key(order_num)
,constraint fk_order_member FOREIGN key(fk_member_num) REFERENCES member_table(member_num)
,constraint fk_order_category foreign key(fk_category_num) references order_state_table(category_num)
);

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


-- 고객 후기 테이블 --
create table review_table
(review_num number not null -- 후기 번호 필수+고유 시퀀스 사용
,subject    varchar2(50) not null -- 후기 제목  필수
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
,emailFlag  varchar2(1) default 0
,smsFlag    varchar2(1) default 0
,email varchar2(50)
,mobile varchar2(20) 
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

drop table one_inquiry_table;

insert into one_inquiry_table(one_inquiry_num, fk_category_num, subject, content, emailFlag, smsFlag, fk_member_num, mobile, email ) 
values(seq_one_inquiry_table.nextval,?,?,?,?,?,?,?,?);

select *
from one_inquiry_table;

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
,subject    varchar2(50) not null
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
,subject varchar2(50) not null
,content varchar2(4000) not null
,write_date date default sysdate
,hits   number default 0
,fk_category_num    number not null
,constraint pk_FAQ_table primary key(FAQ_num)
,constraint fk_FAQ_category FOREIGN key(fk_category_num) REFERENCES inquiry_category_table(category_num)
);


-- 자주하는 질문 테이블에서 사용할 시퀀스 생성 --
create sequence seq_FAQ_table
start with 1
increment by 1
nomaxvalue
nominvalue
nocycle
nocache;



-- 소고기
insert into product_table (product_num, product_name, price, stock, origin, packing, unit, seller, seller_phone, fk_category_num, fk_subcategory_num) 
values(seq_product_table.nextval, '1등급 한우 갈빗살 구이용 200g(냉장)', '31000', '10', '국내산(한우)', '냉장/종이포장', '1팩', '김진하', '01075653393', 4, 41);
insert into product_table (product_num, product_name, price, stock, origin, packing, unit, seller, seller_phone, fk_category_num, fk_subcategory_num) 
values(seq_product_table.nextval, '1등급 한우 목심 샤브샤브용 200g(냉장)', '32000', '10', '국내산(한우)', '냉장/종이포장', '1팩', '김진하', '01075653393', 4, 41);
insert into product_table (product_num, product_name, price, stock, origin, packing, unit, seller, seller_phone, fk_category_num, fk_subcategory_num) 
values(seq_product_table.nextval, '1등급 한우 안심 추리 200g(냉장)', '35000', '4', '국내산(한우)', '냉장/종이포장', '1팩', '김진하', '01075653393', 4, 41);
insert into product_table (product_num, product_name, price, stock, origin, packing, unit, seller, seller_phone, fk_category_num, fk_subcategory_num) 
values(seq_product_table.nextval, '1등급 한우 알사태 수육용 500g(냉장)', '34000', '6', '국내산(한우)', '냉장/종이포장', '1팩', '김진하', '01075653393', 4, 41);
insert into product_table (product_num, product_name, price, stock, origin, packing, unit, seller, seller_phone, fk_category_num, fk_subcategory_num) 
values(seq_product_table.nextval, '1등급 한우 채끝 스키야끼용 200g(냉장)', '30000', '10', '국내산(한우)', '냉장/종이포장', '1팩', '김진하', '01075653393', 4, 41);
insert into product_table (product_num, product_name, price, stock, origin, packing, unit, seller, seller_phone, fk_category_num, fk_subcategory_num) 
values(seq_product_table.nextval, '1등급 한우 홍두깨 육전용 200g(냉장)', '32000', '10', '국내산(한우)', '냉장/종이포장', '1팩', '김진하', '01075653393', 4, 41);
insert into product_table (product_num, product_name, price, stock, origin, packing, unit, seller, seller_phone, fk_category_num, fk_subcategory_num) 
values(seq_product_table.nextval, '와규 MB4+안심 스테이크 200g(냉장)', '33000', '8', '국내산(한우)', '냉장/종이포장', '1팩', '김진하', '01075653393', 4, 41);
insert into product_table (product_num, product_name, price, stock, origin, packing, unit, seller, seller_phone, fk_category_num, fk_subcategory_num) 
values(seq_product_table.nextval, '와규 MB4+채끝 스테이크 200g(냉장)', '33000', '10', '국내산(한우)', '냉장/종이포장', '1팩', '김진하', '01075653393', 4, 41);
insert into product_table (product_num, product_name, price, stock, origin, packing, unit, seller, seller_phone, fk_category_num, fk_subcategory_num) 
values(seq_product_table.nextval, '초이스 찜갈비 2kg(냉동)', '58000', '5', '국내산(한우)', '냉동/종이포장', '1팩', '김진하', '01075653393', 4, 41);

commit;

select *
from product_table;


update product_table set product_name = '1등급 한우 갈빗살 구이용 200g(냉장)'
where product_num = 1;

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


update product_table set sale = 10
where product_num = 1;



-- 돼지고기
insert into product_table (product_num, product_name, price, stock, origin, packing, unit, seller, seller_phone, fk_category_num, fk_subcategory_num) 
values(seq_product_table.nextval, '국내산 목살 양념구이', '12900', '15', '국내산', '냉동/종이포장', '1팩', '김진하', '01075653393', 4, 42);
insert into product_table (product_num, product_name, price, stock, origin, packing, unit, seller, seller_phone, fk_category_num, fk_subcategory_num) 
values(seq_product_table.nextval, '매콤한맛 삼겹살구이 (냉동)', '4900', '10', '돼지고기(브라질산)', '냉동/종이포장', '1팩', '김진하', '01075653393', 4, 42);
insert into product_table (product_num, product_name, price, stock, origin, packing, unit, seller, seller_phone, fk_category_num, fk_subcategory_num) 
values(seq_product_table.nextval, '무한생제 1등급 한동 다짐육 300g(냉장)', '58000', '5', '국내산', '냉장/종이포장', '1팩', '김진하', '01075653393', 4, 42);
insert into product_table (product_num, product_name, price, stock, origin, packing, unit, seller, seller_phone, fk_category_num, fk_subcategory_num) 
values(seq_product_table.nextval, '바베큐맛 삼겹살구이 (냉동)', '4900', '12', '돼지고기(브라질산)', '냉동/종이포장', '1팩', '김진하', '01075653393', 4, 42);
insert into product_table (product_num, product_name, price, stock, origin, packing, unit, seller, seller_phone, fk_category_num, fk_subcategory_num) 
values(seq_product_table.nextval, '베요타 프레사 구이용 200g(냉동)', '18000', '14', '스페인산', '냉동/종이포장', '1팩', '김진하', '01075653393', 4, 42);
insert into product_table (product_num, product_name, price, stock, origin, packing, unit, seller, seller_phone, fk_category_num, fk_subcategory_num) 
values(seq_product_table.nextval, '베요타 플루마 구이용 200g(냉동)', '18500', '10', '스페인산', '냉동/종이포장', '1팩', '김진하', '01075653393', 4, 42);
insert into product_table (product_num, product_name, price, stock, origin, packing, unit, seller, seller_phone, fk_category_num, fk_subcategory_num) 
values(seq_product_table.nextval, '세보데깜뽀 플루마 구이용 200g(냉동)', '16500', '10', '스페인산', '냉동/종이포장', '1팩', '김진하', '01075653393', 4, 42);
insert into product_table (product_num, product_name, price, stock, origin, packing, unit, seller, seller_phone, fk_category_num, fk_subcategory_num) 
values(seq_product_table.nextval, '연저육찜', '15000', '6', '국내산', '냉장/종이포장', '1팩', '김진하', '01075653393', 4, 42);
insert into product_table (product_num, product_name, price, stock, origin, packing, unit, seller, seller_phone, fk_category_num, fk_subcategory_num) 
values(seq_product_table.nextval, '짭쪼름한맛 삼겹살구이 (냉동)', '4900', '15', '돼지고기(브라질산)', '냉동/종이포장', '1팩', '김진하', '01075653393', 4, 42);


commit;


-- 닭고기
insert into product_table (product_num, product_name, price, stock, origin, packing, unit, seller, seller_phone, fk_category_num, fk_subcategory_num) 
values(seq_product_table.nextval, 'BIG BITE 오키더키 2종', '5900', '10', '국내산', '냉장/종이포장', '1팩', '김진하', '01075653393', 4, 43);
insert into product_table (product_num, product_name, price, stock, origin, packing, unit, seller, seller_phone, fk_category_num, fk_subcategory_num) 
values(seq_product_table.nextval, '골든치킨 봉', '7900', '10', '국내산', '냉동/종이포장', '1팩', '김진하', '01075653393', 4, 43);
insert into product_table (product_num, product_name, price, stock, origin, packing, unit, seller, seller_phone, fk_category_num, fk_subcategory_num) 
values(seq_product_table.nextval, '골든치킨 텐더스틱', '7400', '15', '국내산', '냉동/종이포장', '1팩', '김진하', '01075653393', 4, 43);
insert into product_table (product_num, product_name, price, stock, origin, packing, unit, seller, seller_phone, fk_category_num, fk_subcategory_num) 
values(seq_product_table.nextval, '닭가슴살 큐브 스테이크 500g', '7900', '10', '국내산', '냉동/종이포장', '1팩', '김진하', '01075653393', 4, 43);
insert into product_table (product_num, product_name, price, stock, origin, packing, unit, seller, seller_phone, fk_category_num, fk_subcategory_num) 
values(seq_product_table.nextval, '닭한마리 칼국수 밀키트', '12000', '4', '국내산', '냉장/종이포장', '1팩', '김진하', '01075653393', 4, 43);
insert into product_table (product_num, product_name, price, stock, origin, packing, unit, seller, seller_phone, fk_category_num, fk_subcategory_num) 
values(seq_product_table.nextval, '동물복지 닭가슴살 큐브 스테이크 갈릭500g(냉동)', '7900', '10', '국내산', '냉동/종이포장', '1팩', '김진하', '01075653393', 4, 43);
insert into product_table (product_num, product_name, price, stock, origin, packing, unit, seller, seller_phone, fk_category_num, fk_subcategory_num) 
values(seq_product_table.nextval, '버팔로 치킨 봉 스파이시', '11000', '10', '국내산', '냉동/종이포장', '1팩', '김진하', '01075653393', 4, 43);
insert into product_table (product_num, product_name, price, stock, origin, packing, unit, seller, seller_phone, fk_category_num, fk_subcategory_num) 
values(seq_product_table.nextval, '사리듬뿍 순살 닭갈비 대용량', '16700', '10', '국내산', '냉장/종이포장', '1팩', '김진하', '01075653393', 4, 43);
insert into product_table (product_num, product_name, price, stock, origin, packing, unit, seller, seller_phone, fk_category_num, fk_subcategory_num) 
values(seq_product_table.nextval, '유기농 치킨 커틀렛 300g', '4900', '15', '국내산', '냉동/종이포장', '1팩', '김진하', '01075653393', 4, 43);
insert into product_table (product_num, product_name, price, stock, origin, packing, unit, seller, seller_phone, fk_category_num, fk_subcategory_num) 
values(seq_product_table.nextval, '초계 닭무침', '4300', '10', '국내산', '냉장/종이포장', '1팩', '김진하', '01075653393', 4, 43);
insert into product_table (product_num, product_name, price, stock, origin, packing, unit, seller, seller_phone, fk_category_num, fk_subcategory_num) 
values(seq_product_table.nextval, '춘천식 닭갈비 밀키트', '13000', '11', '국내산', '냉장/종이포장', '1팩', '김진하', '01075653393', 4, 43);
insert into product_table (product_num, product_name, price, stock, origin, packing, unit, seller, seller_phone, fk_category_num, fk_subcategory_num) 
values(seq_product_table.nextval, '태양초 닭볶음탕 밀키트', '11000', '15', '국내산', '냉장/종이포장', '1팩', '김진하', '01075653393', 4, 43);


-- 수산 생선류
insert into product_table (product_num, product_name, price, stock, origin, packing, unit, seller, seller_phone, fk_category_num, fk_subcategory_num) 
values(seq_product_table.nextval, '고추장굴비 200g(냉동)', '15900', '50', '국산', '냉동/종이포장', '1통', '김진하', '01075653393', 3, 31);
insert into product_table (product_num, product_name, price, stock, origin, packing, unit, seller, seller_phone, fk_category_num, fk_subcategory_num) 
values(seq_product_table.nextval, '동해손질가자미 350g(냉동)', '7900', '10', '국산', '냉동/종이포장', '1팩', '김진하', '01075653393', 3, 31);
insert into product_table (product_num, product_name, price, stock, origin, packing, unit, seller, seller_phone, fk_category_num, fk_subcategory_num) 
values(seq_product_table.nextval, '맘 아픈 굴비 1.4kg(20마리)(냉동)', '26500', '15', '국산', '냉동/종이포장', '1팩', '김진하', '01075653393', 3, 31);
insert into product_table (product_num, product_name, price, stock, origin, packing, unit, seller, seller_phone, fk_category_num, fk_subcategory_num) 
values(seq_product_table.nextval, '민물장어 2마리 450g내외(생물)', '45500', '20', '국산', '냉장/종이포장', '1팩', '김진하', '01075653393', 3, 31);
insert into product_table (product_num, product_name, price, stock, origin, packing, unit, seller, seller_phone, fk_category_num, fk_subcategory_num) 
values(seq_product_table.nextval, '바다장어 2마리 450g내외(생물)', '24900', '10', '국산', '냉장/종이포장', '1팩', '김진하', '01075653393', 3, 31);


-- 수산 오징어
insert into product_table (product_num, product_name, price, stock, origin, packing, unit, seller, seller_phone, fk_category_num, fk_subcategory_num) 
values(seq_product_table.nextval, '깨끗하게 손질된 오징어 두마리(생물)', '14900', '15', '국내산', '냉장/종이포장', '1팩', '김진하', '01075653393', 3, 32);
insert into product_table (product_num, product_name, price, stock, origin, packing, unit, seller, seller_phone, fk_category_num, fk_subcategory_num) 
values(seq_product_table.nextval, '동해안 찜용 오징어 330g(냉동)', '11900', '22', '국내산', '냉장/종이포장', '1팩', '김진하', '01075653393', 3, 32);
insert into product_table (product_num, product_name, price, stock, origin, packing, unit, seller, seller_phone, fk_category_num, fk_subcategory_num) 
values(seq_product_table.nextval, '모리타니산 자숙문어 한마리(냉동)', '27000', '33', '모리타니산', '냉동/종이포장', '1마리', '김진하', '01075653393', 3, 32);
insert into product_table (product_num, product_name, price, stock, origin, packing, unit, seller, seller_phone, fk_category_num, fk_subcategory_num) 
values(seq_product_table.nextval, '문어 슬라이스 120g(냉장)', '9900', '26', '모리타니산', '냉장/종이포장', '1팩', '김진하', '01075653393', 3, 32);
insert into product_table (product_num, product_name, price, stock, origin, packing, unit, seller, seller_phone, fk_category_num, fk_subcategory_num) 
values(seq_product_table.nextval, '손질 통오징어', '8300', '30', '국산', '냉동/종이포장', '1팩', '김진하', '01075653393', 3, 32);


-- 수산 새우 게
insert into product_table (product_num, product_name, price, stock, origin, packing, unit, seller, seller_phone, fk_category_num, fk_subcategory_num) 
values(seq_product_table.nextval, '갓 잡아올린 신선한 생새우', '18900', '10', '국산', '냉장/종이포장', '1팩', '김진하', '01075653393', 3, 33);
insert into product_table (product_num, product_name, price, stock, origin, packing, unit, seller, seller_phone, fk_category_num, fk_subcategory_num) 
values(seq_product_table.nextval, '손질 가을수꽃게 6조각(중 300~400g)(냉동)', '14900', '15', '국산', '냉동/종이포장', '1팩', '김진하', '01075653393', 3, 33);
insert into product_table (product_num, product_name, price, stock, origin, packing, unit, seller, seller_phone, fk_category_num, fk_subcategory_num) 

values(seq_product_table.nextval, '싱싱 흰다리새우(중 220~270g)(냉동)', '10500', '15', '국산', '냉동/종이포장', '1팩', '김진하', '01075653393', 3, 33);

select * from product_table;

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

update {memberTable} set {passwordColumn} = {sha256 돌린값} where {id} = 'eunhey';