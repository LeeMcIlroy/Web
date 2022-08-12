
function headerUiController(){
    var el,
        _nav,
        _gnb,
        _gnbMenu,
        _gnbMenuList,
        _depth2List,
        _depth2;

    // var currentTarget;

    // setResponsive();
    function init(){

        el = $('#header');
        _nav = el.find('.gnb');
        _gnb = el.find('.gnb-wrap');
        _depth1 = _gnb.find('.depth1');
        _gnbMenuList = _depth1.find('.item');

        _gnbMenu = el.find('.depth2-menu');
        _depth2 = _gnbMenu.find('.depth2');
        _depth2List = _depth2.find('.item-d2');

        _depth3 = _gnbMenu.find('.depth3-wrap')
        _depth3List = _depth3.find('.depth3');

        _mainH = $('.main-header-wrap');
        _topLogo = _mainH.find('.top-logo');
        _topLogoImg = _topLogo.find('img');

        setResponsive();

        return this;
    }

    function setResponsive(){
        var winwidth = $(window).width();
        if( winwidth > 1024 ) {
            reset();
            setGnb();

        } else {
            //reset();
            setGnbMobile();
            //_gnbMenu.hide();
            // if( _gnb.find('.active').length ){
            //     _gnb.find('.active').children('ul').show();
            // }
            _gnb.off();
            //_depth3List.css('background','red');
            // if( _depth3List.hasClass('active') == true){
            //     $(this).css('background','pink');
                //$(this).parent().show().addClass('active');
                //$(this).parent().parent().show().addClass('active');

            //}
           
            
        }
    };

    function setGnb(){

        _gnb.on('mouseenter', function(){
            headerState(true);
            // setTimeout(function(){
            //     imgChange(true);
            // },100);
        });

        _nav.on('mouseleave', function(){
            headerState(false);
        });

        $('.menu-closed-pc').on('click', function(){
            headerState(false);
        });
    }

    function setGnbMobile(){
        _gnb.off();
        _nav.off('mouseleave');

        
        //open
        $('.toggle-btn').on('click', function(){
            el.addClass('gnb-open');
            $('body').addClass('overflow-hidden');
            if ($(_depth2).find(_depth3).length) {
                $(_depth3).siblings(_depth2List).addClass('icon');
            }
        });

        //close
        $('.mo-closed').on('click', function(){
            el.removeClass('gnb-open');
            $('body').removeClass('overflow-hidden');
            $('.depth1-wrap').children('li').removeClass('active');
        });

        //$(_depth3List).css('background','pink');
        

        _gnbMenuList.off().on('click', function(e){
            e.stopPropagation();

            if($(this).parent().hasClass('active')){
                $(this).next('.depth2-menu').stop().slideUp(200);
                $(this).parent().removeClass('active');
                //$(this).parent().css('background','red');
                return false;
            }

            _gnbMenuList.parent().find('.depth2-menu').stop().slideUp(200);
            $(this).next('.depth2-menu').stop().slideDown(200);

            _gnbMenuList.parent().removeClass('active');
            $(this).parent().addClass('active');
        });

        _depth2List.off().on('click', function(e){
            e.stopPropagation();

            if($(this).parent().hasClass('active')){
                $(this).next('.depth3-wrap').stop().slideUp(200);
                $(this).parent().removeClass('active');
                return false;
            }
            _depth2List.parent().find('.depth3-wrap').stop().slideUp(200);
            $(this).next('.depth3-wrap').stop().slideDown(200);

            _depth2List.parent().removeClass('active');
            $(this).parent().addClass('active');
            
        });


    }

    function headerState(check){
        //open
        if(check){
            el.addClass('gnb-open');
            if (el.hasClass('white')) {
                el.removeClass('white');
            }
            _gnbMenu.show();

            $('.top-search').removeClass('sch-open');
            $('.top-lang').removeClass('active');

            $('body').addClass('show');

        }
        //close
        else if(!check){
            // currentTarget = _gnb.children('.active');
            el.removeClass('gnb-open');
            if (!el.hasClass('white')) {
                el.addClass('white');
            }
            // currentTarget.addClass('active');
            $('body').removeClass('show');
        }
    }

    function reset(){
        //_gnbMenu.hide();
        el.removeClass('gnb-open');
        $('body').removeClass('overflow-hidden');
        // $('.depth1-wrap').children('li').removeClass('active');
    }

    // function imgChange(logoChange){
        

    //     if (logoChange) {
    //         _topLogoImg.attr("src","../../assets/images/gclabs-logo.png");
            
    //     } else if (!logoChange) {
    //         if (!_mainH.hasClass('fixed')) {
    //             _topLogoImg.attr("src","../../assets/images/gclabs-logo-wh.png");
    //         } else if (_mainH.hasClass('fixed')) {
    //             _topLogoImg.attr("src","../../assets/images/gclabs-logo.png");
    //         }
    //     } 
    // }

    return init();
}

function topSearch(){
    $('.top-search .btn-search').on('click', function(){
        $(this).parent().toggleClass('sch-open');
        $('#header').removeClass('gnb-open');
        $('.top-lang').removeClass('active'); 
        $('#header').toggleClass('overflow-x');
    });
}

function topLang(){
    var select_tit = $('.top-lang .curr-lang a');
    var select_tit_in = select_tit.find('span');
    select_tit.on('click', function(){
        $(this).parent().parent().toggleClass('active');
        $('#header').removeClass('gnb-open');
        $('.top-search').removeClass('sch-open'); 
        
    });
    $('.lang-list li a').on('click', function(){
        var li_txt = $(this).find('span').text();
        select_tit.text(li_txt);
    });
    $(window).on('click', function(e){
        if (!$(e.target).closest('.top-lang')[0]) {
            $('#header .top-lang').removeClass('active');
        }
    });
}

function topLangMo(){
    $('.mobile-top .lang-list li a').on('click', function(){
        if(!$(this).parent().hasClass('active')) {
            $(this).parent().addClass('active')
                .siblings().removeClass('active');
        }
    });
}

function footerSite() {
    $('.foot-util .link').on('click', function() {
        $(this).next('.layer-foot-site').addClass('open');
    });
    $('.layer-foot-site .layer-close').on('click', function () {
        $(this).parent().removeClass('open');
    });
}

function accordionList() {
    var accWarp = $(".accordion-list");
    var accItem = accWarp.find(".acc-item");
    var accTit = accItem.find(".acc-tit");
    var accCont = accItem.find(".acc-cont");

    $(".accordion-list li:first-child").addClass("on").find(".acc-cont").show();

    accTit.on('click', function(){
        if ($(this).next().css("display") == "none") {
            $(this).parent().addClass("on").find('.acc-cont').slideDown()
                .parent().siblings().find(accCont).slideUp();
        } else {
            $(this).parent().removeClass("on").find('.acc-cont').slideUp();
            
        }
    });
}

function tabs() {
    var _winW = $(window).width();
    var _tabs = $(".tabs-wrap .tab");
    var _tabBtn = _tabs.find("a");
    var _tabCont = $(".section-tab");

    _tabBtn.on('click', function () {
        //$('.tab').removeClass('active');
        //$(this).addClass('active');

        var idx = $(this).parent().index();

        _tabs.removeClass("active");
        _tabs.eq(idx).addClass("active");

        if(_tabCont) {
            _tabCont.removeClass("active");
            _tabCont.eq(idx).addClass("active");
        }

        toTop();
    });

    if($(".tabs-wrap .tabs").hasClass('mobile-tabs')) {
        if( _winW > 1023 ) {
            _tabBtn.off();
        }
    }
}

function filterOn() {
    var filterCont = $('.search-filter-box');
    //filterCont.hide();
    //
    $('.btn-filter').on('click', function () {  
        $(this).toggleClass('on');   
        filterCont.toggleClass('open').slideToggle();      
    });
}

function toTop() {
    var btnTop = $('.to-top');
    var footerTop = $('.footer-wrap').offset().top - $(window).height();

    $(window).scroll(function () {
        var scrollTop = $(this).scrollTop();

        if ($(window).scrollTop() > $('#header').height()) {
            btnTop.addClass('active');
        } else {
            btnTop.removeClass('active');
        }

        if (footerTop < scrollTop) {
            $('.floating-wrap').css({position:'absolute',bottom:'-' + (footerTop - 30) + 'px'});
        } else {
            $('.floating-wrap').css({position:'',bottom:'30px'});
        }
    });

    btnTop.on('click', function (e) {
        e.preventDefault();
        $('html, body').animate({scrollTop: 0}, 600)
    });
}

function layerPopup() {
    var winW = $(window).width(),
        winH = $(window).height(),
        trigger = $('.layer'),
        mobileTrigger = $('.layer.on-mobile'),
        close = $('.popup-close');

    trigger.unbind('click').click(function(){
        var el = $(this).attr('href'),
            elH = $(el).height();

        $(el).css({
            'margin-top' : - ((elH / 2)) + $(window).scrollTop(),
            'z-index' : 1001,
            'opacity' : 0,
            // 'top' : '50px'
        });

        // $(el).css({
        //     'z-index' : 1001,
        //     'opacity' : 0,
        //     'top' : '50px'
        // });

        setTimeout(function(){
            $(el).css({
                'opacity' : 1,
                // 'top' : 0
            });
        },100);

        // $('body').addClass('overflow-hidden');

        // if($('body').hasClass('overflow-hidden')) {
            $('body').append('<div class="dimmed-layer" aria-hidden="true"></div>');

            if($('.dimmed-layer').length > 1) {
                $('.dimmed-layer').eq(0).remove();
            }
        // }

        $(this).addClass('current');
        $(el).addClass('active');
        $(el).attr('tabindex', '0').focus();

        if($(el).hasClass('full')) {
            if( winW < 1024 ) {
                $(el).find('.popup-wrap').css('height', winH - 100);
            }
            // console.log('aa');
        }

        return false;
    });

    if( winW > 799 ) {
        mobileTrigger.off();
    }

    close.unbind('click').click(function() {
        $(this).parent().parent().removeClass('active');
        $(this).parent().parent().css({'z-index':1000});
        // $(this).parent().parent().parent().find(trigger).focus();
        // $('.current').focus();
        trigger.removeClass('current');
        if ($('.dimmed-layer').length ) {
            $('.dimmed-layer').remove();
        }
        // $('body').removeClass('overflow-hidden');

        return false;
    });
}

function selectBox() {
    var selectBox = $('.selectbox'),
        target = selectBox.find('.select'),
        list = selectBox.find('.lists'),
        selectTarget = selectBox.find('.lists li');

    target.on('click', function(e) {
        e.stopPropagation();

        $(this).parent().toggleClass('on');
        $(this).next(list).stop().slideToggle(200);
    })

    selectTarget.on('click', function(e) {
        var selectText = $(this).text();

        e.stopPropagation();

        $(this).addClass('selected').siblings('li').removeClass('selected');
        $(this).parent().siblings(target).text(selectText).addClass('active');
        $(this).parent().parent().removeClass('on')
        list.stop().slideUp(200);
    })
}

// 첨부파일
function fileAdd() {
    var fileTarget = $('.file-box .upload-hidden'); 
    
    fileTarget.on('change', function(){ // 값이 변경되면 
        if(window.FileReader){ // modern browser 
            var filename = $(this)[0].files[0].name; 
        } else { // old IE 
            var filename = $(this).val().split('/').pop().split('\\').pop(); // 파일명만 추출 
        } // 추출한 파일명 삽입 
        $(this).siblings('.upload-name').val(filename); });
}

function onLayer(){
    function init(){
        _tarWarp = $('.request .item, .clinical .item');
        _tar = _tarWarp.find('.box');
        responsiveLayer();
        return this;
    }

    function responsiveLayer (){
        var winwidth = $(window).width();
        if( winwidth > 1024 ) {  
            imgHover();
        } else {
            imgClick();
        }
        return;
    }

    function imgHover() {
        _tar.on('mouseenter', function(){
            $(this).closest(_tarWarp).addClass('on');
        })
        _tarWarp.on('mouseleave', function(){
            $(this).removeClass('on');
        });
    }
    function imgClick() {
        _tarWarp.off();
        _tar.off();
        // _tar.off().on('click', function(){
        //     $(this).parent().toggleClass('on');
        // })
    }

    return init();
}

$(document).ready(function () {
    topSearch();
    headerUiController();
    topLang();
    topLangMo();
    footerSite();
    accordionList();
    tabs();
    layerPopup();
    filterOn();
    selectBox();
    onLayer();
    fileAdd()

    $(window).resize(function() {
        headerUiController();
        tabs();
        layerPopup();
        onLayer();
        toTop();
    });

    $('.pause').on('click', function() {
        $(this).removeClass('active');
        $('.play').addClass('active');
        $('.sliders').slick('slickPause');
    });

    $('.play').on('click', function() {
        $(this).removeClass('active');
        $('.pause').addClass('active');
        $('.sliders').slick('slickPlay');
    });

    $('.main-visual .sliders').slick({
        slidesToShow: 1,
        slidesToScroll: 1,
        autoplay: true,
        autoplaySpeed: 5000,
        arrows: false,
        dots: true,
    });

    $('.test-slider').slick({
        slidesToShow: 4,
        slidesToScroll: 1,
        infinite: false,
        responsive: [
            {
                breakpoint: 1024,
                settings: {
                    slidesToShow: 3,
                    slidesToScroll: 1,
                }
            },
            {
                breakpoint: 800,
                settings: {
                    slidesToShow: 1,
                    slidesToScroll: 1,
                    adaptiveHeight: true 
                }
            }
        ]
    });

    $('.infect .sliders').slick({
        slidesToShow: 1,
        slidesToScroll: 1,
        infinite: false,
        arrows: false,
        dots: true,
    });

	$('.about .sliders').slick({
        slidesToShow: 1,
        slidesToScroll: 1,
        infinite: false,
        arrows: false,
        dots: true,
    });

    toTop();
    
});