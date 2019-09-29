
$( window ).load(function() {

	var clickHandler = 'click';

	function extend( a, b ) {
		for( var key in b ) {
			if( b.hasOwnProperty( key ) ) {
				a[key] = b[key];
			}
		}
		return a;
	};

	function Animocon(el, options) {
		this.el = el;
		this.options = extend( {}, this.options );
		extend( this.options, options );

		this.checked = false;

		this.timeline = new mojs.Timeline();

		for(var i = 0, len = this.options.tweens.length; i < len; ++i) {
			this.timeline.add(this.options.tweens[i]);
		}

		var self = this;
		this.el.addEventListener(clickHandler, function() {
			if( self.checked ) {
				self.options.onUnCheck();
			}
			else {
				self.options.onCheck();
				self.timeline.replay();
			}
			self.checked = !self.checked;
		});
	}

	Animocon.prototype.options = {
		tweens : [
			new mojs.Burst({})
		],
		onCheck : function() { return false; },
		onUnCheck : function() { return false; }
	};

	var items = [].slice.call(document.querySelectorAll('.fav-heart-button5'));

	function init(x) {

		//for (i = 0; i < items.length; i++) {

		/* Icon 5 */
		var el5 = items[x].querySelector('button.icobutton5'), el5span = el5.querySelector('i');
		var scaleCurve5 = mojs.easing.path('M0,100 L25,99.9999983 C26.2328835,75.0708847 19.7847843,0 100,0');
		new Animocon(el5, {
			tweens : [
				// burst animation
				new mojs.Burst({
					parent: 	el5,
					count: 		15,
					radius: 	{20:80},
					angle: 		{ 0: 140, easing: mojs.easing.bezier(0.1, 1, 0.3, 1) },
					children: {
						fill: 			'#DF0101',
						radius: 		20,
						opacity: 		0.6,
						duration: 	1500,
						easing: 		mojs.easing.bezier(0.1, 1, 0.3, 1)
					}
				}),
				// icon scale animation
				new mojs.Tween({
					duration : 800,
					easing: mojs.easing.bezier(0.1, 1, 0.3, 1),
					onUpdate: function(progress) {
						var scaleProgress = scaleCurve5(progress);
						el5span.style.WebkitTransform = el5span.style.transform = 'scale3d(' + progress + ',' + progress + ',1)';
					}
				})
			],
			onCheck : function() {
				el5.style.color = '#DF0101';
			},
			onUnCheck : function() {
				el5.style.color = '#C0C1C3';
			}
		});
		/* Icon 5 */

		/* Icon 14 */

		//}

	};

	//init();
	for (var i = 0; i < items.length; i++) {
    init(i);
  }

});
