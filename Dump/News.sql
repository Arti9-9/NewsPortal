PGDMP                         y            web3    12.2    12.2     +           0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                      false            ,           0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                      false            -           0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                      false            .           1262    16654    web3    DATABASE     �   CREATE DATABASE web3 WITH TEMPLATE = template0 ENCODING = 'UTF8' LC_COLLATE = 'Russian_Russia.1251' LC_CTYPE = 'Russian_Russia.1251';
    DROP DATABASE web3;
                postgres    false            �            1255    16733    counting_comments()    FUNCTION     �   CREATE FUNCTION public.counting_comments() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
   INSERT INTO news (count_comment) 
   SELECT count(*) FROM comment C, news N WHERE C.id_news_id=N.id;
    RETURN NULL;
END
$$;
 *   DROP FUNCTION public.counting_comments();
       public          postgres    false            �            1259    16677    comment    TABLE     �   CREATE TABLE public.comment (
    id integer NOT NULL,
    user_id_id integer NOT NULL,
    date timestamp(0) without time zone NOT NULL,
    text character varying(800) NOT NULL,
    id_news_id integer NOT NULL
);
    DROP TABLE public.comment;
       public         heap    user    false            �            1259    16673    comment_id_seq    SEQUENCE     w   CREATE SEQUENCE public.comment_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 %   DROP SEQUENCE public.comment_id_seq;
       public          user    false            �            1259    16655    doctrine_migration_versions    TABLE     �   CREATE TABLE public.doctrine_migration_versions (
    version character varying(191) NOT NULL,
    executed_at timestamp(0) without time zone DEFAULT NULL::timestamp without time zone,
    execution_time integer
);
 /   DROP TABLE public.doctrine_migration_versions;
       public         heap    user    false            �            1259    16686    news    TABLE       CREATE TABLE public.news (
    id integer NOT NULL,
    name character varying(255) NOT NULL,
    date timestamp(0) without time zone NOT NULL,
    annotation character varying(255) NOT NULL,
    text text NOT NULL,
    count_view integer DEFAULT 0 NOT NULL
);
    DROP TABLE public.news;
       public         heap    user    false            �            1259    16675    news_id_seq    SEQUENCE     t   CREATE SEQUENCE public.news_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 "   DROP SEQUENCE public.news_id_seq;
       public          user    false            �            1259    16663    user    TABLE     I  CREATE TABLE public."user" (
    id integer NOT NULL,
    email character varying(180) NOT NULL,
    roles json NOT NULL,
    password character varying(255) NOT NULL,
    name character varying(255) NOT NULL,
    surname character varying(255) NOT NULL,
    father_name character varying(255) DEFAULT NULL::character varying
);
    DROP TABLE public."user";
       public         heap    user    false            �            1259    16661    user_id_seq    SEQUENCE     t   CREATE SEQUENCE public.user_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 "   DROP SEQUENCE public.user_id_seq;
       public          user    false            '          0    16677    comment 
   TABLE DATA           I   COPY public.comment (id, user_id_id, date, text, id_news_id) FROM stdin;
    public          user    false    207   !       "          0    16655    doctrine_migration_versions 
   TABLE DATA           [   COPY public.doctrine_migration_versions (version, executed_at, execution_time) FROM stdin;
    public          user    false    202   �!       (          0    16686    news 
   TABLE DATA           L   COPY public.news (id, name, date, annotation, text, count_view) FROM stdin;
    public          user    false    208   _"       $          0    16663    user 
   TABLE DATA           X   COPY public."user" (id, email, roles, password, name, surname, father_name) FROM stdin;
    public          user    false    204   J*       /           0    0    comment_id_seq    SEQUENCE SET     =   SELECT pg_catalog.setval('public.comment_id_seq', 13, true);
          public          user    false    205            0           0    0    news_id_seq    SEQUENCE SET     :   SELECT pg_catalog.setval('public.news_id_seq', 44, true);
          public          user    false    206            1           0    0    user_id_seq    SEQUENCE SET     9   SELECT pg_catalog.setval('public.user_id_seq', 8, true);
          public          user    false    203            �
           2606    16684    comment comment_pkey 
   CONSTRAINT     R   ALTER TABLE ONLY public.comment
    ADD CONSTRAINT comment_pkey PRIMARY KEY (id);
 >   ALTER TABLE ONLY public.comment DROP CONSTRAINT comment_pkey;
       public            user    false    207            �
           2606    16660 <   doctrine_migration_versions doctrine_migration_versions_pkey 
   CONSTRAINT        ALTER TABLE ONLY public.doctrine_migration_versions
    ADD CONSTRAINT doctrine_migration_versions_pkey PRIMARY KEY (version);
 f   ALTER TABLE ONLY public.doctrine_migration_versions DROP CONSTRAINT doctrine_migration_versions_pkey;
       public            user    false    202            �
           2606    16693    news news_pkey 
   CONSTRAINT     L   ALTER TABLE ONLY public.news
    ADD CONSTRAINT news_pkey PRIMARY KEY (id);
 8   ALTER TABLE ONLY public.news DROP CONSTRAINT news_pkey;
       public            user    false    208            �
           2606    16670    user user_pkey 
   CONSTRAINT     N   ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_pkey PRIMARY KEY (id);
 :   ALTER TABLE ONLY public."user" DROP CONSTRAINT user_pkey;
       public            user    false    204            �
           1259    16705    idx_9474526c6b39f0d0    INDEX     N   CREATE INDEX idx_9474526c6b39f0d0 ON public.comment USING btree (id_news_id);
 (   DROP INDEX public.idx_9474526c6b39f0d0;
       public            user    false    207            �
           1259    16685    idx_9474526c9d86650f    INDEX     N   CREATE INDEX idx_9474526c9d86650f ON public.comment USING btree (user_id_id);
 (   DROP INDEX public.idx_9474526c9d86650f;
       public            user    false    207            �
           1259    16671    uniq_8d93d649e7927c74    INDEX     P   CREATE UNIQUE INDEX uniq_8d93d649e7927c74 ON public."user" USING btree (email);
 )   DROP INDEX public.uniq_8d93d649e7927c74;
       public            user    false    204            �
           2620    16737    comment check_comments    TRIGGER     �   CREATE TRIGGER check_comments AFTER INSERT OR DELETE OR UPDATE ON public.comment FOR EACH ROW EXECUTE FUNCTION public.counting_comments();

ALTER TABLE public.comment DISABLE TRIGGER check_comments;
 /   DROP TRIGGER check_comments ON public.comment;
       public          user    false    209    207            �
           2606    16700    comment fk_9474526c6b39f0d0    FK CONSTRAINT     |   ALTER TABLE ONLY public.comment
    ADD CONSTRAINT fk_9474526c6b39f0d0 FOREIGN KEY (id_news_id) REFERENCES public.news(id);
 E   ALTER TABLE ONLY public.comment DROP CONSTRAINT fk_9474526c6b39f0d0;
       public          user    false    2720    208    207            �
           2606    16694    comment fk_9474526c9d86650f    FK CONSTRAINT     ~   ALTER TABLE ONLY public.comment
    ADD CONSTRAINT fk_9474526c9d86650f FOREIGN KEY (user_id_id) REFERENCES public."user"(id);
 E   ALTER TABLE ONLY public.comment DROP CONSTRAINT fk_9474526c9d86650f;
       public          user    false    2714    204    207            '   �   x�3�4�4202�50�5�T04�22�20༰����^l��5&�Ӑ˘���6\l�Q���b��xaÅM6pq�p�b��|a�}@�Ɯ�p�@f@i+���F��{ $��G!^��=... ��      "   �   x��л
�0�����@����9k�NYJ)%KI��:P�c�A����0_�ez�N�}�l��X��|[ֺ11H9AIE�~H�:�N�@�9-���� R@�`dP��%X�] \Rȩ`��X���Z$*Z��@������Ԓ �����I]% �$�ɗ���	U��x�1>�(~�      (   �  x��XˎW]{��n�@�G��30�C	#�ʒ� �<o"F)��M�lz<�q��ݖ�n�B�$眺�n��$�&R$����<u����������>/v����������O}�|�c�O�� ����b����G~��P���7'�IJ�O��NNy!��I�W�!:+v}������L���.F�9|~�P_<��wwq�R��qq�p����a���vZ��V{�uz[���v����NO��������'��|��k<$P9���FR���EB9�ǚU(�����c��'���/�!O�-Џd��d���������u:�U�`������0hfP&���X�P{.m���	�*�+��eJu 89Z� %�q�`^,�$�V� ?�!;fA�'�S��Wp�
Y4:�^
l�T�+�{{��)3�5UU信	Lύ����LB�#f�Qq0���g��=��&S�;	���5p�bҐ�gο��WfWn.ZXϘ�U~���Qd�RYçg0`�rO�Gc�u?e�� 	U�o]�{sہy�i����p]�M����,�Bd� �A����nL#��1@0�	�vz�
0U�=߿�T�:x37<P'�k��	#v�0�BE�GJ��7��	�4Du��H$���3�+n���t���/�ZQ1�g���N�V�U���H�#���Mʅ4�`�
���U���Tg0�I�"�E+g0�<�MVf�-��t�h�/2���Bd_�N$��$�CE)5k�(&"BO��trRR\<eڕ����swY!�O"�T��Q�`Q!v�ӡ!�G�ĖĮ�A�X�S������{���#�A"u%D�p��e���OYA�B���$������I�� �D��։��q��+�ת,���7�R��Gr76�F�u����˦s�Ù�1"(K"�U�p����Hmъ�컴u͗!��|{���B�!>	瑏Z��~�|<Yڽ�0=�
�P�	ߧ�q �nޢ�#�Ђx�X�u��v���Ȣ&�;a��j�����ӷA��Ѷ��~T�/kMs^�s���;�c��d�.>ch��Y�p�C7��?'!���HA�G"qBAt��a�$3N5$�w������T��º���TH0�f,��e���?�� Fk�}�j�-��bŖd�L�3����b$K�[�A�>Ռ��x��ܔ�� �4�솚�Ŝ6���'��U�ֺ��=��5S��j�ڇ6�^��b�� XEߗ�"s�wv�!������kt��M��T��*�
��?��>ɪ�?��(���,��?����l���V�8Q]}��R��.X�k�h�1�]�}��Wtԉ'Є��I��,�֊�zَ���Vj�X3a�V�ɳ6��i!�L�9=d����0u#pŁ��*�÷��+̚z�V߳���TQŃRAlJĚ�m�u{�D����̰d1?��m��Â�%��;�T΁@�}=,&�w宦A��xP�y�j+6��AF�5AD�ی�2 ���YSz��zym2��&�����ۭﵺ�Ц\9v��O�����o6���|�����t˨z�m��m���Z�9(���Ҋc�:V뽕^�Q��伪��v-6�ÒaUp��l�ԪB���%j���g�lp�cՅ���խ���z�6�\+�T�;�����߬�����l����3#4��!p�r(���>�\!Zι�NNKΈfv�����|�V\N�#���� I�5]����DPH�6i������{.0Nds�M*��<ʫ"ִ-b�F#KZ][�ܗQb��S-�������ms���22�M�����TШ���{�i�`�8����X���0� ���n W�m��Ai&�t�kk�l�wk׮677��*������k[x�]�������]2������ZwA������Z�4��є��\E�q���U�ҕb��\�D�ac�3�!���Fh�5{���6�+߬����	��l_      $   �  x����n�0�sx�*7* 9 ����%�	$�4�B�'rZ��.���<u�tk'U��^�y�%��Ӵ�`��ْ?���/���Wuӵ��]��N���_p5Il�<'H}aA/o��B��[)�tiׯvg��e}�?񧰾F��*��5Vd;(Xǲ�2Ч$ׄ@��k������p�լa���Hp�я�I3� U4\<���H�
���u �+�ne����[Ұ�v�����i�5	�}��#[E�&"�K�$ZȞ�e�(>(2p[�P,�V�6�3��	�=57K�^by������������F��ńrIp�)����R�j��"k�/!7�[� |��k�o�7�Ƿ�;��N����Wѫd_GoR%Bpu{Z������jLYky;j����#0��)K�j=4Y5���
�=��Y ��ߑ)��v���%�E�}2���-�k�.�Et�Mj�{o��U�;^��fN����K^��d]VԹp�v���")Sw$eP+f����Dy�^���|��(�뢓�6q��8�w����b�ur��mΗ��e��T�����%�k�� �U�΋�/���E��I�V=�LZ���.?��}���4'���`�s�4M��~�#�پ��߾���$�J�~�ЂQ     