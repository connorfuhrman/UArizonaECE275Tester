'''
File to generate solution files for ECE 275 Docker containers (testers for HW/Projects).

Has to real use outside of a docker container. 
'''

# Import the ProgramTester installed from pip as 
# pip3 install uarizona-ece275-outputfileTester
from OutputFileTester import ProgramTester as PT
import os, sys

def generateSolution(exeName):
	# Generate the solution files
	pt = PT.ProgramTester(exeName)
	pt.make_solutionFiles()
	# Move the solution files to /tester directory
	os.system("mkdir solution && mv sol_*.txt solution")
	os.system("tar -czf solutionfiles.tar.gz solution") # Tar the generated files
	os.system("mv solutionfiles.tar.gz /tester/solutionfiles.tar.gz") # Move them into the tester directory
	
def main(exeName):
	generateSolution(exeName)
	
if __name__ == "__main__":
	main(sys.argv[1]) # pass in the executable name as command argument