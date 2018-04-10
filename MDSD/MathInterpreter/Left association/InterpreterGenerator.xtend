/*
 * generated by Xtext 2.13.0
 */
package org.xtext.mathinterpreter.generator

import org.eclipse.emf.ecore.resource.Resource
import org.eclipse.xtext.generator.AbstractGenerator
import org.eclipse.xtext.generator.IFileSystemAccess2
import org.eclipse.xtext.generator.IGeneratorContext
import org.xtext.mathinterpreter.interpreter.MathExp
import org.xtext.mathinterpreter.interpreter.Expression
//import org.xtext.mathinterpreter.interpreter.Parenthesis
import javax.swing.JOptionPane
import org.xtext.mathinterpreter.interpreter.Add
import org.xtext.mathinterpreter.interpreter.Sub
import org.xtext.mathinterpreter.interpreter.Mul
import org.xtext.mathinterpreter.interpreter.Div
import org.xtext.mathinterpreter.interpreter.Number
import org.xtext.mathinterpreter.interpreter.Parenthesis

/**
 * Generates code from your model files on save.
 * 
 * See https://www.eclipse.org/Xtext/documentation/303_runtime_concepts.html#code-generation
 */
class InterpreterGenerator extends AbstractGenerator {

	override void doGenerate(Resource resource, IFileSystemAccess2 fsa, IGeneratorContext context) {
		val math = resource.allContents.filter(MathExp).next
		val result = math.compute
		System.out.println("Math expression = "+math.display)
		JOptionPane.showMessageDialog(null, "result = "+result,"Math Language", JOptionPane.INFORMATION_MESSAGE)
	}
	
		def double compute(MathExp math) { 
		math.exp.computeExp
	}
	
	def double computeExp(Expression exp) {
		val result = exp.computeOp
		result
	}
	
	def dispatch computeOp(Add add) {  add.left.computeExp+add.right.computeExp }
	def dispatch computeOp(Sub sub) {  sub.left.computeExp-sub.right.computeExp }
	def dispatch computeOp(Mul mul) {  mul.left.computeExp*mul.right.computeExp }
	def dispatch computeOp(Div div) {  div.left.computeExp/div.right.computeExp }
	def dispatch computeOp(Number num) {  num.value }
	def dispatch computeOp(Parenthesis par) {  par.exp.computeExp }

	def CharSequence display(MathExp math) '''Math[�math.exp.displayOp�]'''
	def dispatch CharSequence displayOp(Add op) '''Addition[�op.left.displayOp�+�op.right.displayOp�]'''
	def dispatch CharSequence displayOp(Sub op) '''Subtraction[�op.left.displayOp�-�op.right.displayOp�]'''
	def dispatch CharSequence displayOp(Mul op) '''Multiplication[�op.left.displayOp�*�op.right.displayOp�]'''
	def dispatch CharSequence displayOp(Div op) '''Division[�op.left.displayOp�/�op.right.displayOp�]'''
	def dispatch CharSequence displayOp(Number num) '''�num.value�'''
	def dispatch CharSequence displayOp(Parenthesis par) '''�par.exp.displayOp�'''
}