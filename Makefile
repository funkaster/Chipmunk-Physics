OBJECTS=src/chipmunk.o src/cpArbiter.o src/cpArray.o src/cpBB.o src/cpBBTree.o src/cpBody.o src/cpCollision.o \
		src/cpHashSet.o src/cpPolyShape.o src/cpShape.o src/cpSpace.o src/cpSpaceComponent.o src/cpSpaceHash.o \
		src/cpSpaceQuery.o src/cpSpaceStep.o src/cpSpatialIndex.o src/cpSweep1D.o src/cpVect.o
CONSTRAINTS=src/constraints/cpConstraint.o src/constraints/cpDampedRotarySpring.o src/constraints/cpDampedSpring.o \
			src/constraints/cpGearJoint.o src/constraints/cpGrooveJoint.o src/constraints/cpPinJoint.o src/constraints/cpPivotJoint.o \
			src/constraints/cpRatchetJoint.o src/constraints/cpRotaryLimitJoint.o src/constraints/cpSimpleMotor.o \
			src/constraints/cpSlideJoint.o


CC=../emscripten/emcc
LD=../emscripten/emld
CFLAGS=-Iinclude/chipmunk -g

%.o: %.c
	${CC} ${CFLAGS} -c $< -o $@

chipmunk.o: ${OBJECTS} ${CONSTRAINTS}
	${CC} ${OBJECTS} ${CONSTRAINTS} -o $@

all:  chipmunk.o
	${CC} -g -O1 $< -o chipmunk.js

clean:
	rm -rf src/*.o src/constraints/*.o
	rm -f chipmunk.a chipmunk.js

test:
	${CC} -O1 ${CFLAGS} --post-js wrapper.js src/cpVect.c -o cpVect.js
