google.maps.__gjsload__('stats', function(_){var h1=function(){this.b=new _.cl},i1=function(a){var b=0,c=0;a.b.forEach(function(a){b+=a.cp;c+=a.Do});return c?b/c:0},j1=function(a,b,c){var d=[];_.bb(a,function(a,c){d.push(c+b+a)});return d.join(c)},k1=function(a){var b={};_.bb(a,function(a,d){b[(0,window.encodeURIComponent)(d)]=(0,window.encodeURIComponent)(a).replace(/%7C/g,"|")});return j1(b,":",",")},l1=function(){var a=_.qg[35]?_.N(_.uf(_.Q),11):_.yw,b=window.document;this.l=_.gj;this.f=a+"/maps/gen_204";this.j=b},m1=function(a,b,c,d){var e=
{};e.host=window.document.location&&window.document.location.host||window.location.host;e.v=a;e.r=Math.round(1/b);c&&(e.client=c);d&&(e.key=d);return e},n1=function(a,b,c,d){var e=_.M(_.Q,0,1);this.m=a;this.C=b;this.l=e;this.f=c;this.j=d;this.b=new _.cl;this.B=_.Ta()},p1=function(a,b,c,d,e){var f=_.M(_.Q,23,500);var g=_.M(_.Q,22,2);this.D=a;this.F=b;this.H=f;this.l=g;this.C=c;this.m=d;this.B=e;this.f=new _.cl;this.b=0;this.j=_.Ta();o1(this)},o1=function(a){window.setTimeout(function(){q1(a);o1(a)},
Math.min(a.H*Math.pow(a.l,a.b),2147483647))},r1=function(a,b,c){a.f.set(b,c)},q1=function(a){var b=m1(a.F,a.C,a.m,a.B);b.t=a.b+"-"+(_.Ta()-a.j);a.f.forEach(function(a,d){a=a();0<a&&(b[d]=Number(a.toFixed(2))+(_.Cm()?"-if":""))});a.D.b({ev:"api_snap"},b);++a.b},s1=function(a,b,c,d,e){this.B=a;this.C=b;this.m=c;this.j=d;this.l=e;this.f={};this.b=[]},t1=function(a,b,c){var d=_.zf;this.j=a;_.F.bind(this.j,"set_at",this,this.l);_.F.bind(this.j,"insert_at",this,this.l);this.B=b;this.C=d;this.m=c;this.f=
0;this.b={};this.l()},u1=function(){this.j=_.N(_.Q,6);this.C=_.tf();this.b=new l1;new t1(_.Mi,(0,_.t)(this.b.b,this.b),!!this.j);var a=_.N(new _.nf(_.Q.data[3]),1);this.D=a.split(".")[1]||a;this.F={};this.B={};this.m={};this.H={};this.N=_.M(_.Q,0,1);_.fj&&(this.l=new p1(this.b,this.D,this.N,this.j,this.C))};h1.prototype.f=function(a,b,c){this.b.set(_.Qc(a),{cp:b,Do:c})};
l1.prototype.b=function(a,b){b=b||{};var c=_.ik().toString(36);b.src="apiv3";b.token=this.l;b.ts=c.substr(c.length-6);a.cad=k1(b);a=j1(a,"=","&");a=this.f+"?target=api&"+a;this.j.createElement("img").src=a;(b=_.jb.__gm_captureCSI)&&b(a)};
n1.prototype.D=function(a,b){b=_.p(b)?b:1;this.b.isEmpty()&&window.setTimeout((0,_.t)(function(){var a=m1(this.C,this.l,this.f,this.j);a.t=_.Ta()-this.B;var b=this.b;_.dl(b);for(var e={},f=0;f<b.b.length;f++){var g=b.b[f];e[g]=b.G[g]}_.Sz(a,e);this.b.clear();this.m.b({ev:"api_maprft"},a)},this),500);b=this.b.get(a,0)+b;this.b.set(a,b)};s1.prototype.D=function(a){this.f[a]||(this.f[a]=!0,this.b.push(a),2>this.b.length&&_.pA(this,this.F,500))};
s1.prototype.F=function(){for(var a=m1(this.C,this.m,this.j,this.l),b=0,c;c=this.b[b];++b)a[c]="1";a.hybrid=+_.gm();this.b.length=0;this.B.b({ev:"api_mapft"},a)};t1.prototype.l=function(){for(var a;a=this.j.removeAt(0);){var b=a.ao;a=a.timestamp-this.C;++this.f;this.b[b]||(this.b[b]=0);++this.b[b];if(20<=this.f&&!(this.f%5)){var c={};c.s=b;c.sr=this.b[b];c.tr=this.f;c.te=a;c.hc=this.m?"1":"0";this.B({ev:"api_services"},c)}}};u1.prototype.ba=function(a){a=_.Qc(a);this.F[a]||(this.F[a]=new s1(this.b,this.D,this.N,this.j,this.C));return this.F[a]};u1.prototype.ca=function(a){a=_.Qc(a);this.B[a]||(this.B[a]=new n1(this.b,this.D,this.j,this.C));return this.B[a]};u1.prototype.f=function(a){if(this.l){this.m[a]||(this.m[a]=new _.jB,r1(this.l,a,function(){return b.ib()}));var b=this.m[a];return b}};u1.prototype.R=function(a){if(this.l){this.H[a]||(this.H[a]=new h1,r1(this.l,a,function(){return i1(b)}));var b=this.H[a];return b}};
var v1=new u1;_.ce("stats",v1);});
