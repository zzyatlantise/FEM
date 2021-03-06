function [K,F] = assembleSolidMechanics(p,e,t, lambda, mu,force)
	ndof=2*size(p,2);
	K=sparse(ndof,ndof);
	F=zeros(ndof,1);
	dofs=zeros(6,1);
	
	for i=1:size(t,2)
		nodes=t(1:3,i);
		x=p(1,nodes); y=p(2,nodes);
		dofs(1:2:end) = 2*nodes-1; dofs(2:2:end)=2*nodes;
		
		Ke = stiffness(x,y,mu,lambda);
		Fe = loadvec(x,y,force);
		
		K(dofs,dofs) = K(dofs,dofs)+Ke;
		F(dofs) = F(dofs)+Fe;
	end
