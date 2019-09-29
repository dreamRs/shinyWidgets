
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

	var items = [].slice.call(document.querySelectorAll('.fav-heart-button8'));

	function init(x) {

		//for (i = 0; i < items.length; i++) {

		/* Icon 8 */
		var el8 = items[x].querySelector('button.icobutton8'), el8span = el8.querySelector('i');
		var scaleCurve8 = mojs.easing.path('M0,100 L25,99.9999983 C26.2328835,75.0708847 19.7847843,0 100,0');
		new Animocon(el8, {
			tweens : [
				// burst animation
				new mojs.Burst({
					parent: 			el8,
					count: 				28,
					radius: 			{50:110},
					children: {
						fill: 			'#DF0101',
						opacity: 		0.6,
						radius: 		{'rand(5,20)':0},
						scale: 			1,
						swirlSize: 	15,
						duration: 	1600,
						easing: 		mojs.easing.bezier(0.1, 1, 0.3, 1),
						isSwirl: 		true
					}
				}),
				// burst animation
				new mojs.Burst({
					parent: 	el8,
					count: 		18,
					angle: 		{0:10},
					radius: 	{140:200},
					children: {
						fill: 			'#DF0101',
						shape: 			'line',
						opacity: 		0.6,
						radius: 		{'rand(5,20)':0},
						scale: 			1,
						stroke: 		'#DF0101',
						strokeWidth: 2,
						duration: 	1800,
						delay: 			300,
						easing: 		mojs.easing.bezier(0.1, 1, 0.3, 1)
					}
				}),
				// burst animation
				new mojs.Burst({
					parent: 	el8,
					radius: 	{40:80},
					count: 		18,
					children: {
						fill: 			'#DF0101',
						opacity: 		0.6,
						radius: 		{'rand(5,20)':0},
						scale: 			1,
						swirlSize:  15,
						duration: 	2000,
						delay: 			500,
						easing: 		mojs.easing.bezier(0.1, 1, 0.3, 1),
						isSwirl: 		true
					}
				}),
				// burst animation
				new mojs.Burst({
					parent: 	el8,
					count: 		20,
					angle: 		{0:-10},
					radius: 	{90:130},
					children: {
						fill: 			'#DF0101',
						opacity: 		0.6,
						radius: 		{'rand(10,20)':0},
						scale: 			1,
						duration: 	3000,
						delay: 			750,
						easing: 		mojs.easing.bezier(0.1, 1, 0.3, 1)
					}
				}),
				// icon scale animation
				new mojs.Tween({
					duration : 400,
					easing: mojs.easing.back.out,
					onUpdate: function(progress) {
						var scaleProgress = scaleCurve8(progress);
						el8span.style.WebkitTransform = el8span.style.transform = 'scale3d(' + progress + ',' + progress + ',1)';
					}
				})
			],
			onCheck : function() {
				el8.style.color = '#DF0101';
			},
			onUnCheck : function() {
				el8.style.color = '#C0C1C3';
			}
		});
		/* Icon 8 */

		//}

	};

	//init();
	for (var i = 0; i < items.length; i++) {
    init(i);
  }

});
