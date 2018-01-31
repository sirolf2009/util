package com.sirolf2009.util.akka

import akka.actor.AbstractActor
import de.erichseifert.gral.data.DataTable
import de.erichseifert.gral.graphics.Insets2D
import de.erichseifert.gral.plots.XYPlot
import de.erichseifert.gral.plots.lines.DiscreteLineRenderer2D
import de.erichseifert.gral.ui.InteractivePanel
import java.awt.Color
import java.text.SimpleDateFormat
import java.util.HashMap
import java.util.Map
import java.util.function.Consumer
import javax.swing.JFrame
import org.eclipse.xtend.lib.annotations.Data
import org.eclipse.xtend.lib.annotations.FinalFieldsConstructor

@FinalFieldsConstructor class GralChartActor extends AbstractActor {

	public static val Consumer<LineSetup> line = [
		plot.setLineRenderers(data, new DiscreteLineRenderer2D())
	]
	public static val Consumer<LineSetup> red = [
		val color = new Color(150, 40, 40)
		plot.getPointRenderers(data).get(0).color = color
		try {
			plot.getLineRenderers(data).get(0).setColor(color)
		} catch(Exception e) {
		}
	]
	public static val Consumer<LineSetup> green = [
		val color = new Color(40, 150, 40)
		plot.getPointRenderers(data).get(0).color = color
		try {
			plot.getLineRenderers(data).get(0).setColor(color)
		} catch(Exception e) {
		}
	]
	public static val Consumer<LineSetup> blue = [
		val color = new Color(40, 40, 150)
		plot.getPointRenderers(data).get(0).color = color
		try {
			plot.getLineRenderers(data).get(0).setColor(color)
		} catch(Exception e) {
		}
	]
	public static val Consumer<LineSetup> labeled = [
		plot.getPointRenderers(data).get(0).valueVisible = true
	]

	extension val ActorHelper helper = new ActorHelper(this)
	val String name
	val DataTable data = new DataTable(Long, Double)
	val Map<String, DataTable> series = new HashMap()
	var XYPlot plot
	var InteractivePanel panel
	var boolean firstValue = true
	var boolean shouldPaint = true

	override createReceive() {
		return receiveBuilder -> [
			match(Double) [
				add(System.currentTimeMillis(), it)
				onUpdateReceived()
			]
			match(ChartPoint) [
				add(x, y)
				onUpdateReceived()
			]
			match(ChartSeriesPoint) [
				if(!series.containsKey(name)) {
					val data = new DataTable(Long, Double)
					data.add(x, y)
					series.put(name, data)
					onUpdateReceived()
					plot.add(data)
					modifiers.accept(new LineSetup(data, plot))
				} else {
					val data = series.get(name)
					data.add(x, y)
				}
				onUpdateReceived()
			]
			match(Pause) [
				shouldPaint = false
			]
			match(Resume) [
				shouldPaint = true
			]
		]
	}

	def synchronized add(long x, double y) {
		data.add(x, y)
	}

	def void onUpdateReceived() {
		if(firstValue) {
			plot = new XYPlot(data) => [
				setLineRenderers(data, new DiscreteLineRenderer2D())
				val color = new Color(100, 100, 100)
				getPointRenderers(data).get(0).valueVisible = false
				getLineRenderers(data).get(0).color = color
				plotArea.background = new Color(52, 57, 61)
				insets = new Insets2D.Double(0, 64, 40, 0)
				background = new Color(15, 16, 17)
				getAxisRenderer(XYPlot.AXIS_X).tickColor = Color.WHITE
				getAxisRenderer(XYPlot.AXIS_X).minorTickColor = Color.WHITE
				getAxisRenderer(XYPlot.AXIS_Y).tickColor = Color.WHITE
				getAxisRenderer(XYPlot.AXIS_Y).minorTickColor = Color.WHITE
				getAxisRenderer(XYPlot.AXIS_X).tickLabelFormat = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm:ss")
			]
			new JFrame() => [
				title = name
				setSize(1024, 900)
				panel = new InteractivePanel(plot)
				contentPane.add(panel)
				defaultCloseOperation = JFrame.EXIT_ON_CLOSE
				visible = true
			]
			Thread.sleep(1000)
			new Thread [
				while(true) {
					try {
						Thread.sleep(100)
						if(shouldPaint) {
							render()
						}
					} catch(Exception e) {
						e.printStackTrace()
					}
				}
			].start()
			firstValue = false
		}
	}

	def synchronized render() {
		panel.repaint()
	}

	@Data public static class ChartPoint {
		val long x
		val double y
	}

	@Data public static class ChartSeriesPoint {
		val String name
		val long x
		val double y
		val Consumer<LineSetup> modifiers

		new(String name, long x, double y) {
			this(name, x, y, [])
		}

		new(String name, long x, double y, Consumer<LineSetup> modifiers) {
			this.name = name
			this.x = x
			this.y = y
			this.modifiers = modifiers
		}
	}

	@Data public static class LineSetup {
		val DataTable data
		val XYPlot plot
	}

	@Data public static class Pause {
	}

	@Data public static class Resume {
	}

}
